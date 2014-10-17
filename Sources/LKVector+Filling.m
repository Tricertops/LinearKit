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
    vDSP_vclr(LKUnwrap(self), self.length);
}


- (void)fill:(LKFloat)value {
    if (value) {
        vDSP_vfill(&value, LKUnwrap(self), self.length);
    }
    else {
        [self clear];
    }
}


- (void)generateFrom:(LKFloat)start by:(LKFloat)step {
    vDSP_vramp(&start, &step, LKUnwrap(self), self.length);
}


- (void)generateFrom:(LKFloat)start to:(LKFloat)end {
    vDSP_vgen(&start, &end, LKUnwrap(self), self.length);
}



- (void)setValues:(LKVector *)vector {
    LKLength length = MIN(self.length, vector.length);
    // Adds zero, because there is no specialized function for vector copy with stride.
    vDSP_vsadd(LKUnwrap(vector), &LKZero, LKUnwrap(self), length); //BENCH: Other?
}



@end


