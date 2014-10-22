//
//  LKVector+Filling.m
//  LinearKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"





@implementation LKVector (Filling)



- (void)clear {
    //TODO: Variable length operation.
    LK_vDSP(vclr)(LKUnwrap(self), LKUnsigned(self.length));
}


- (void)fill:(LKFloat)value {
    //TODO: Variable length operation with optimization for zeros.
    if (value) {
        LK_vDSP(vfill)(&value, LKUnwrap(self), LKUnsigned(self.length));
    }
    else {
        [self clear];
    }
}


- (void)generateFrom:(LKFloat)start by:(LKFloat)step {
    //TODO: Variable length operation.
    LK_vDSP(vramp)(&start, &step, LKUnwrap(self), LKUnsigned(self.length));
}


- (void)generateFrom:(LKFloat)start to:(LKFloat)end {
    //TODO: Variable length operation.
    LK_vDSP(vgen)(&start, &end, LKUnwrap(self), LKUnsigned(self.length));
}



- (void)setValues:(LKVector *)vector {
    //! Reversing responsibility, because the other vector may know how to optimize the transaction.
    [vector copyValuesTo:self];
}



@end


