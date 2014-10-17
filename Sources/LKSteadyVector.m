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
        self->_length = length;
        if (length) {
            self->_values = calloc(length, sizeof(LKFloat));
            
            if (values) {
                LKLength bytes = length * sizeof(LKFloat);
                memcpy(self->_values, values, bytes);
            }
        }
    }
    return self;
}


- (void)dealloc {
    free(self->_values);
}



@end


