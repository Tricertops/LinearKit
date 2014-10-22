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
        self->_type = encodedType;
        self->_typeSize = [self.class sizeOfType:encodedType];
        //TODO: Check for supported types.
        self->_normalizationFactor = factor;
    }
    return self;
}



+ (LKFloat)largestPositiveValueForType:(const char *)encodedType {
    static NSDictionary *largestValues = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        largestValues = @{
                          @"c": @((LKFloat)CHAR_MAX),
                          @"s": @((LKFloat)SHRT_MAX),
                          @"i": @((LKFloat)INT_MAX),
                          @"l": @((LKFloat)LONG_MAX),
                          @"q": @((LKFloat)LONG_LONG_MAX),
                          
                          @"C": @((LKFloat)UCHAR_MAX),
                          @"S": @((LKFloat)USHRT_MAX),
                          @"I": @((LKFloat)UINT_MAX),
                          @"L": @((LKFloat)ULONG_MAX),
                          @"Q": @((LKFloat)ULONG_LONG_MAX),
                          
                          @"f": @((LKFloat)FLT_MAX),
                          @"d": @((LKFloat)DBL_MAX),
                          
                          @"B": @((LKFloat)YES),
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
                  @"c": @(sizeof(char)),
                  @"s": @(sizeof(short)),
                  @"i": @(sizeof(int)),
                  @"l": @(sizeof(long)),
                  @"q": @(sizeof(long long)),
                  
                  @"C": @(sizeof(unsigned char)),
                  @"S": @(sizeof(unsigned short)),
                  @"I": @(sizeof(unsigned int)),
                  @"L": @(sizeof(unsigned long)),
                  @"Q": @(sizeof(unsigned long long)),
                  
                  @"f": @(sizeof(float)),
                  @"d": @(sizeof(double)),
                  
                  @"B": @(sizeof(_Bool)),
                  };
    });
    NSNumber *largest = [sizes objectForKey:@(encodedType)];
    return [largest LK_floatValue];
}



- (LKVector *)createVectorFromData:(NSData *)data {
    LKInteger length = (LKInteger)(data.length / self.typeSize);
    LKVector *vector = [LKVector vectorWithLength:length];
    //TODO: Use appropriate function.
    return vector;
}


- (NSMutableData *)createDataFromVector:(LKVector *)vector {
    LKUInteger length = (LKUInteger)vector.length * self.typeSize;
    NSMutableData *data = [NSMutableData dataWithLength:length];
    //TODO: Use appropriate function.
    return data;
}



@end


