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
    LK_vDSP(vclr)(LKUnwrap(self), LKUnsigned(self.length));
}


- (void)fill:(LKFloat)value {
    if (value) {
        LK_vDSP(vfill)(&value, LKUnwrap(self), LKUnsigned(self.length));
    }
    else {
        [self clear];
    }
}


- (void)generateFrom:(LKFloat)start by:(LKFloat)step {
    LK_vDSP(vramp)(&start, &step, LKUnwrap(self), LKUnsigned(self.length));
}


- (void)generateFrom:(LKFloat)start to:(LKFloat)end {
    LK_vDSP(vgen)(&start, &end, LKUnwrap(self), LKUnsigned(self.length));
}



- (void)setValues:(LKVector *)vector {
    //TODO: Inverse using -copyValuesTo: for LKLazyVector
    LKInteger length = MIN(self.length, vector.length);
    // Adds zero, because there is no specialized function for vector copy with stride.
    LK_vDSP(vsadd)(LKUnwrap(vector), &LKZero, LKUnwrap(self), LKUnsigned(length)); //BENCH: Other?
}



@end


