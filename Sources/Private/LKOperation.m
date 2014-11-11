//
//  LKOperationVector.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKOperation.h"
#import "LKPrivate.h"



@interface LKOperation ()

@property (readonly) LKOperationBlock block;

@end



#pragma mark -

@implementation LKOperation



#pragma mark Creating


+ (instancetype)operationWithLength:(LKInteger)length block:(LKOperationBlock)block {
    return [[self alloc] initWithLength:length block:block];
}


- (instancetype)initWithLength:(LKInteger)length block:(LKOperationBlock)block {
    self = [super init];
    if (self) {
        self->_length = length;
        self->_block = block;
    }
    return self;
}


- (instancetype)init {
    return [self initWithLength:0 block:nil];
}



#pragma mark Using


- (LKVector *)vectorize {
    LKVector *vector = [LKVector vectorWithLength:self.length];
    [self fillVector:vector];
    return vector;
}


- (LKOperation *)copy {
    return self;
}


- (LKOperation *)copyWithZone:(__unused NSZone *)zone {
    return [self copy];
}


- (void)fillVector:(LKVector *)vector {
    if ( ! vector) return;
    if (vector.length > self.length) {
        @throw LKException(LKLengthException, @"Vector is too long for this Operation: Vector %li, Operation %li", vector.length, self.length);
    }
    self.block(vector, LKUnsigned(vector.length));
}



#pragma mark Factory


+ (LKOperation *)wrap:(LKVector *)vector {
    return [LKOperation operationWithLength:vector.length block:^(LKVector *destination, LKUInteger length) {
        if ([destination isReverseOf:vector]) {
            //! Reverse in place.
            vDSP_vrvrs(LKUnwrap(vector), length);
        }
        else if (vector == destination) {
            //! Do nothing.
        }
        else {
            //! Copy values.
            // Adds zero, because there is no specialized function for vector copy with stride.
            LK_vDSP(vsadd)(LKUnwrap(vector), &LKZero, LKUnwrap(destination), length); //BENCH: Other fake functions?
        }
    }];
}



@end


