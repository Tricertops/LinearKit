//
//  VKSteadyVector.m
//  VectorKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKPrivateVector.h"



@interface VKSteadyVector : VKVector

@end





@implementation VKSteadyVector



@synthesize values = _values;
@synthesize stride = _stride;
@synthesize length = _length;



- (VKVector *)initWithLength:(VKLength)length {
    self = [super init];
    if (self) {
        self->_values = malloc(length * sizeof(VKFloat));
        self->_stride = 1;
        self->_length = length;
        
        [self clear];
    }
    return self;
}


- (void)dealloc {
    free(self->_values);
}



#define VKUnwrap(VKVector)      VKVector->_values, VKVector->_stride, VKVector->_length


- (void)clear {
    vDSP_vclr(VKUnwrap(self));
}


- (void)fill:(VKFloat)value {
    vDSP_vfill(&value, VKUnwrap(self));
}


- (void)generateFrom:(VKFloat)start by:(VKFloat)step {
    vDSP_vramp(&start, &step, VKUnwrap(self));
}


- (void)generateFrom:(VKFloat)start to:(VKFloat)end {
    vDSP_vgen(&start, &end, VKUnwrap(self));
}



- (VKVector *)copyWithZone:(__unused NSZone *)zone {
    VKVector *copy = [[VKVector alloc] initWithLength:self->_length];
    copy.values = self;
    return copy;
}


- (void)setValues:(VKVector *)vector {
    VKLength length = MIN(self->_length, vector.length);
    vDSP_mmov(vector.values, self->_values, 1, length, 1, 1);
}



@end


