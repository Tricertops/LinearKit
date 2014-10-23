//
//  LKGenerator.m
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKGenerator.h"
#import "LKPrivate.h"



@interface LKGenerator ()

@property (readonly) LKGeneratorBlock block;

@end



@implementation LKGenerator



#pragma mark - Creating


+ (instancetype)generatorWithBlock:(LKGeneratorBlock)block {
    return [[self alloc] initWithBlock:block];
}


+ (instancetype)generatorWithIndexBlock:(LKGeneratorIndexBlock)block {
    return [[self alloc] initWithBlock:^(LKVector *destination) {
        LKInteger length = destination.length;
        [destination enumerateConcurrently:YES block:^(LKInteger index, LKFloat *reference) {
            *reference = block(index, length);
        }];
    }];
}


- (instancetype)initWithBlock:(LKGeneratorBlock)block {
    self = [super init];
    if (self) {
        self->_block = block;
    }
    return self;
}


- (instancetype)init {
    return [self initWithBlock:nil];
}



#pragma mark - Using


- (LKVector *)vectorizeWithLength:(LKInteger)length {
    LKVector *vector = [LKVector vectorWithLength:length];
    [self fillVector:vector];
    return vector;
}


- (LKGenerator *)copy {
    return self;
}


- (LKGenerator *)copyWithZone:(__unused NSZone *)zone {
    return [self copy];
}


- (void)fillVector:(LKVector *)vector {
    if ( ! vector) return;
    self.block(vector);
}



@end
