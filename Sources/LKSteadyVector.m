//
//  LKSteadyVector.m
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"



@interface LKSteadyVector : LKVector

@end





@implementation LKSteadyVector



@synthesize values = _values;
@synthesize length = _length;


- (LKStride)stride {
    return 1;
}


- (LKVector *)initWithValues:(const LKFloat*)values length:(LKLength)length {
    self = [super initSubclass];
    if (self) {
        if (length) {
            self->_values = malloc(length * sizeof(LKFloat));
            self->_length = length;
            
            if (values) {
                // Matrix copy, where the vectors are 1×N matrices. No strides.
                vDSP_mmov(values, self->_values, 1, length, 1, 1); //BENCH: mmov()
            }
            else {
                [self clear]; //BENCH: calloc()
            }
        }
    }
    return self;
}


- (void)dealloc {
    free(self->_values);
}



@end


