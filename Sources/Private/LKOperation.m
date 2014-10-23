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



@implementation LKOperation



#pragma mark - Creating


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



#pragma mark - Using


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
    if (vector.length <= self.length) {
        @throw LKException(LKLengthException, @"Vector is too long for this Operation: Vector %li, Operation %li", vector.length, self.length);
    }
    self.block(vector, LKUnsigned(vector.length));
}



@end


