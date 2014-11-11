//
//  LKVector+Summing.m
//  LinearKit
//
//  Created by Martin Kiss on 11.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Summing.h"
#import "LKPrivate.h"



@implementation LKVector (Summing)



#pragma mark Sums


- (LKFloat)sum {
    LKFloat sum = LKNAN;
    LK_vDSP(sve)(LKUnwrap(self), &sum, LKUnsigned(self.length));
    return sum;
}


- (LKFloat)magnitudesSum {
    LKFloat magnitudesSum = LKNAN;
    LK_vDSP(svemg)(LKUnwrap(self), &magnitudesSum, LKUnsigned(self.length));
    return magnitudesSum;
}


- (LKFloat)squaresSum {
    LKFloat squaresSum = LKNAN;
    LK_vDSP(svesq)(LKUnwrap(self), &squaresSum, LKUnsigned(self.length));
    return squaresSum;
}


- (LKFloat)signedSquaresSum {
    LKFloat signedSquaresSum = LKNAN;
    LK_vDSP(svs)(LKUnwrap(self), &signedSquaresSum, LKUnsigned(self.length));
    return signedSquaresSum;
}


- (LKOperation *)slidingWindowSum:(LKInteger)window {
    LKVector *subself = [self subvectorWithLength:self.length - window + 1];
    return [subself operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vswsum)(LKUnwrap(self), LKUnwrap(destination), length, LKUnsigned(window));
    }];
}



#pragma mark Integration


- (LKOperation *)runningSumIntegration:(LKFloat)weight {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vrsum)(LKUnwrap(self), &weight, LKUnwrap(destination), length);
    }];
}


- (LKOperation *)simpsonIntegration:(LKFloat)step {
    //TODO: Only out of place.
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vsimps)(LKUnwrap(self), &step, LKUnwrap(destination), length);
    }];
}


- (LKOperation *)trapezoidalIntegration:(LKFloat)step {
    //TODO: Only out of place.
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vsimps)(LKUnwrap(self), &step, LKUnwrap(destination), length);
        vDSP_vtrapz(LKUnwrap(self), &step, LKUnwrap(destination), length);
    }];
}



@end


