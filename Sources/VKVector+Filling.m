//
//  VKVector+Filling.m
//  VectorKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKVector+Private.h"





@implementation VKVector (Filling)



- (void)clear {
    vDSP_vclr(VKUnwrap(self), self.length);
}


- (void)fill:(VKFloat)value {
    if (value) {
        vDSP_vfill(&value, VKUnwrap(self), self.length);
    }
    else {
        [self clear];
    }
}


- (void)generateFrom:(VKFloat)start by:(VKFloat)step {
    vDSP_vramp(&start, &step, VKUnwrap(self), self.length);
}


- (void)generateFrom:(VKFloat)start to:(VKFloat)end {
    vDSP_vgen(&start, &end, VKUnwrap(self), self.length);
}



- (void)setValues:(VKVector *)vector {
    VKLength length = MIN(self.length, vector.length);
    // Adds zero, because there is no specialized function for vector copy with stride.
    vDSP_vsadd(VKUnwrap(vector), &VKZero, VKUnwrap(self), length); //BENCH: Other?
}



@end


