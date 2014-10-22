//
//  LKFormat.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKFormat.h"
#import "LKPrivate.h"
#import "NSNumber.h"



@implementation LKFormat



+ (instancetype)formatWithType:(const char *)encodedType normalized:(BOOL)normalized {
    LKFloat factor = (normalized? [self largestPositiveValueForType:encodedType] : 1);
    return [[self alloc] initWithType:encodedType normalization:factor];
}


- (instancetype)initWithType:(const char *)encodedType normalization:(LKFloat)factor {
    self = [super init];
    if (self) {
        if ([self.class isTypeSupported:encodedType]) {
            @throw LKException(LKFormatException, @"Type “%s” is not supported by LKFormat class", encodedType);
        }
        self->_type = encodedType;
        self->_typeSize = [self.class sizeOfType:encodedType];
        self->_isTypeSigned = [self.class isSignedType:encodedType];
        
        if (isfinite(factor)) {
            @throw LKException(LKFormatException, @"Normalization factor of LKFormat must be a finite number");
        }
        self->_normalizationFactor = factor;
    }
    return self;
}



+ (BOOL)isTypeSupported:(const char *)encodedType {
    static NSSet *supported = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        supported = [NSSet setWithObjects:
                     @(@encode(char)),           //  8-bit   signed
                     @(@encode(short)),          // 16-bit   signed
                     @(@encode(int)),            // 32-bit   signed
                     @(@encode(unsigned char)),  //  8-bit unsigned
                     @(@encode(unsigned short)), // 16-bit unsigned
                     @(@encode(unsigned int)),   // 32-bit unsigned
                     @(@encode(float)),          // single precision
                     @(@encode(double)),         // double precision
                     nil];
    });
    return [supported containsObject:@(encodedType)];
}


+ (LKFloat)largestPositiveValueForType:(const char *)encodedType {
    static NSDictionary *largestValues = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        largestValues = @{
                          @(@encode(char))          : @((LKFloat)CHAR_MAX),
                          @(@encode(short))         : @((LKFloat)SHRT_MAX),
                          @(@encode(int))           : @((LKFloat)INT_MAX),
                          @(@encode(unsigned char)) : @((LKFloat)UCHAR_MAX),
                          @(@encode(unsigned short)): @((LKFloat)USHRT_MAX),
                          @(@encode(unsigned int))  : @((LKFloat)UINT_MAX),
                          @(@encode(float))         : @((LKFloat)FLT_MAX),
                          @(@encode(double))        : @((LKFloat)DBL_MAX),
                          };
    });
    NSNumber *largest = [largestValues objectForKey:@(encodedType)];
    return [largest LK_floatValue];
}


+ (LKUInteger)sizeOfType:(const char *)encodedType {
    static NSDictionary *sizes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizes = @{
                  @(@encode(char))          : @(sizeof(char)),
                  @(@encode(short))         : @(sizeof(short)),
                  @(@encode(int))           : @(sizeof(int)),
                  @(@encode(unsigned char)) : @(sizeof(unsigned char)),
                  @(@encode(unsigned short)): @(sizeof(unsigned short)),
                  @(@encode(unsigned int))  : @(sizeof(unsigned int)),
                  @(@encode(float))         : @(sizeof(float)),
                  @(@encode(double))        : @(sizeof(double)),
                  };
    });
    NSNumber *largest = [sizes objectForKey:@(encodedType)];
    return [largest LK_floatValue];
}


+ (BOOL)isSignedType:(const char *)encodedType {
    static NSSet *signedTypes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signedTypes = [NSSet setWithObjects:
                       @(@encode(char)),   //  8-bit   signed
                       @(@encode(short)),  // 16-bit   signed
                       @(@encode(int)),    // 32-bit   signed
                       @(@encode(float)),  // single precision
                       @(@encode(double)), // double precision
                       nil];
    });
    return [signedTypes containsObject:@(encodedType)];
}



#define LKTypeCompare(encoded, type)    ( [encoded isEqualToString:@(@encode(type))] )

- (LKVector *)createVectorFromData:(NSData *)data {
    LKInteger length = (LKInteger)(data.length / self.typeSize);
    LKVector *vector = [LKVector vectorWithLength:length];
    NSString *type = @(self.type);
    
#define LKCall(type)  ((type *)data.bytes, 1, LKUnwrap(vector), LKUnsigned(length))
    
    if      (LKTypeCompare(type, char)) {
        LK_vDSP(vflt8)LKCall(char);
    }
    else if (LKTypeCompare(type, short)) {
        LK_vDSP(vflt16)LKCall(short);
    }
    else if (LKTypeCompare(type, int)) {
        LK_vDSP(vflt32)LKCall(int);
    }
    else if (LKTypeCompare(type, unsigned char)) {
        LK_vDSP(vfltu8)LKCall(unsigned char);
    }
    else if (LKTypeCompare(type, unsigned short)) {
        LK_vDSP(vfltu16)LKCall(unsigned short);
    }
    else if (LKTypeCompare(type, unsigned int)) {
        LK_vDSP(vfltu32)LKCall(unsigned int);
    }
    else if (LKTypeCompare(type, float)) {
        LKPrecision(// Precision 1: copy
                    vDSP_vsadd((float *)data.bytes, 1, &LKZero,
                               LKUnwrap(vector),
                               LKUnsigned(length)),
                    // Precision 2: convert
                    (vDSP_vspdp)LKCall(float));
    }
    else if (LKTypeCompare(type, double)) {
        LKPrecision(// Precision 1: convert
                    (vDSP_vdpsp)LKCall(double),
                    // Precision 2: copy
                    vDSP_vsaddD((double *)data.bytes, 1, &LKZero,
                                LKUnwrap(vector),
                                LKUnsigned(length)));
    }
    
#undef LKCall
    
    LKFloat factor = self.normalizationFactor;
    if (factor != 1 && factor != 0) {
        LK_vDSP(vsdiv)(LKUnwrap(vector), &factor, LKUnwrap(vector), LKUnsigned(length));
    }
    return vector;
}


- (NSMutableData *)createDataFromVector:(LKVector *)vector {
    LKFloat factor = self.normalizationFactor;
    if (factor != 1 && factor != 0) {
        LKVector *denormalized = [LKVector vectorWithLength:vector.length];
        BOOL isSigned = self.isTypeSigned;
        LKFloat min = (isSigned? -1 : 0);
        LKFloat max = (isSigned? +1 : 1);
        LK_vDSP(vclip)(LKUnwrap(vector), &min, &max, LKUnwrap(denormalized), LKUnsigned(vector.length));
        LK_vDSP(vsmul)(LKUnwrap(denormalized), &factor, LKUnwrap(denormalized), LKUnsigned(vector.length));
        vector = denormalized;
    }
    
    LKUInteger length = (LKUInteger)vector.length * self.typeSize;
    NSMutableData *data = [NSMutableData dataWithLength:length];
    NSString *type = @(self.type);
    
#define LKCall(type)  (LKUnwrap(vector), (type *)data.bytes, 1, length)
    
    if      (LKTypeCompare(type, char)) {
        LK_vDSP(vfix8)LKCall(char);
    }
    else if (LKTypeCompare(type, short)) {
        LK_vDSP(vfix16)LKCall(short);
    }
    else if (LKTypeCompare(type, int)) {
        LK_vDSP(vfix32)LKCall(int);
    }
    else if (LKTypeCompare(type, unsigned char)) {
        LK_vDSP(vfixu8)LKCall(unsigned char);
    }
    else if (LKTypeCompare(type, unsigned short)) {
        LK_vDSP(vfixu16)LKCall(unsigned short);
    }
    else if (LKTypeCompare(type, unsigned int)) {
        LK_vDSP(vfixu32)LKCall(unsigned int);
    }
    else if (LKTypeCompare(type, float)) {
        LKPrecision(// Precision 1: copy
                    vDSP_vsadd(LKUnwrap(vector), &LKZero,
                               (float *)data.bytes, 1,
                               length),
                    // Precision 2: convert
                    (vDSP_vdpsp)LKCall(float));
    }
    else if (LKTypeCompare(type, double)) {
        LKPrecision(// Precision 1: convert
                    (vDSP_vspdp)LKCall(double),
                    // Precision 2: copy
                    vDSP_vsaddD(LKUnwrap(vector), &LKZero,
                                (double *)data.bytes, 1,
                                length));
    }
    
#undef LKCall
    
    return data;
}



@end


