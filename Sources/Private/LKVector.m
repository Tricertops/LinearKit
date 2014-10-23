//
//  LKVector.m
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKPrivate.h"
#import "LKDataVector.h"



@implementation LKVector



#pragma mark - Creating


- (LKVector *)initWithMutableData:(NSMutableData *)data {
    return [[LKDataVector alloc] initWithMutableData:data];
}


+ (LKVector *)vectorWithLength:(LKInteger)length {
    LKUInteger unsignedLength = LKUnsigned(length);
    NSMutableData *data = [NSMutableData dataWithLength:unsignedLength * sizeof(LKFloat)];
    return [[LKVector alloc] initWithMutableData:data];
}


+ (LKVector *)vectorFromData:(NSData *)data format:(LKFormat *)format {
    return [format createVectorFromData:data];
}


- (instancetype)initSubclass {
    return [super init];
}


- (instancetype)init {
    return [self initWithMutableData:nil];
}



#pragma mark - Source


- (LKVector *)copy {
    LKVector *vector = [LKVector vectorWithLength:self.length];
    [self fillVector:vector];
    return vector;
}


- (LKVector *)copyWithZone:(__unused NSZone *)zone {
    return [self copy];
}


- (void)set:(id<LKSource>)source {
    [source fillVector:self];
}


- (void)fillVector:(LKVector *)vector {
    if ( ! vector) return;
    if (vector.length <= self.length) {
        @throw LKException(LKLengthException, @"Vector is too long for this Operation: Vector %li, Operation %li", vector.length, self.length);
    }
    // Adds zero, because there is no specialized function for vector copy with stride.
    LK_vDSP(vsadd)(LKUnwrap(self), &LKZero, LKUnwrap(vector), LKUnsigned(vector.length)); //BENCH: Other fake operation?
}



#pragma mark - Abstract


- (LKFloat *)head {
    return NULL;
}


- (LKInteger)stride {
    return 0;
}


- (LKInteger)length {
    return 0;
}



#pragma mark - Validation


- (BOOL)isIndexValid:(__unused LKInteger)index {
    return (0 <= index && index < self.length);
}


- (void)validateIndex:(LKInteger)index {
    if ( ! [self isIndexValid:index]) {
        @throw LKException(LKIndexException, @"Index %li out of bounds for %@", index, self.debugDescription);
    }
}



#pragma mark - Accessing


- (LKFloat)valueAtIndex:(LKInteger)index {
    [self validateIndex:index];
    if ( ! self.head) return LKNAN;
    return self.head[index * self.stride];
}


- (void)setValue:(LKFloat)value atIndex:(LKInteger)index {
    [self validateIndex:index];
    if ( ! self.head) return;
    self.head[index * self.stride] = value;
}


- (LKFloat*)referenceAtIndex:(LKInteger)index {
    [self validateIndex:index];
    return self.head + (index * self.stride);
}


- (LKFloat*(^)(LKInteger))at {
    return ^LKFloat*(LKInteger index){
        return [self referenceAtIndex:index];
    };
}


- (void)enumerateConcurrently:(BOOL)concurrently block:(void (^)(LKInteger, LKFloat *))block {
    LKFloat* head = self.head;
    LKInteger stride = self.stride;
    LKInteger length = self.length;
    
    if (concurrently) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(LKUnsigned(length), queue, ^(size_t index){
            LKInteger signedIndex = LKSigned(index);
            block(signedIndex, head + (signedIndex * stride));
        });
    }
    else {
        for (LKInteger index = 0; index < length; index++) {
            block(index, head + (index * stride));
        }
    }
}


- (NSMutableData *)copyDataWithFormat:(LKFormat *)format {
    return [format createDataFromVector:self];
}



#pragma mark - Equality


- (NSUInteger)hash {
    __block NSUInteger hash = LKUnsigned(self.length) * LKHashFactor;
    [self enumerateConcurrently:NO block:^(__unused LKInteger index, LKFloat *reference) {
        hash ^= LKHash(*reference);
    }];
    return hash;
}


- (BOOL)isEqual:(LKVector *)other {
    return [self isEqual:other epsilon:0];
}


- (BOOL)isEqual:(LKVector *)other epsilon:(LKFloat)epsilon {
    if (self == other) return YES;
    if ( ! [other isKindOfClass:[LKVector class]]) return NO;
    if (self.length != other.length) return NO;
    
    LKFloat* myHead = self.head;
    LKInteger myStride = self.stride;
    LKFloat* hisHead = other.head;
    LKInteger hisStride = other.stride;
    if ( ! myHead || ! hisHead) return NO;
    
    LKInteger length = MIN(self.length, other.length);
    for (LKInteger index = 0; index < length; index++) {
        LKFloat my = myHead[index * myStride];
        LKFloat his = hisHead[index * hisStride];
        
        if (isnan(my) && isnan(his)) continue;
        if (ABS(my - his) > epsilon) return NO;
    }
    return YES;
}



#pragma mark - Description


- (NSString *)description {
    // [a, b, c, d, ... 20 more ]
    LKInteger printedLength = MIN(self.length, 20);
    
    NSMutableArray *values = [NSMutableArray new];
    for (LKInteger index = 0; index < printedLength; index++) {
        LKFloat value = [self valueAtIndex:index];
        [values addObject:[NSString stringWithFormat:@"%f", value]];
    }
    
    NSMutableString *description = [NSMutableString new];
    [description appendString:@"["];
    [description appendString:[values componentsJoinedByString:@", "]];
    LKInteger more = self.length - printedLength;
    if (more > 0) {
        [description appendFormat:@", ... %li more", more];
    }
    [description appendString:@"]"];
    return description;
}



@end


