//
//  LKVector+Limits.m
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Limits.h"
#import "LKPrivate.h"
#import "LKVector+Generating.h"



@implementation LKVector (Limits)



#pragma mark Clipping


- (LKOperation *)clippedBelow:(LKFloat)lowest {
    return [self clippedBelow:lowest above:LKInfinity];
    //ALT: vDSP_vthr
}


- (LKOperation *)clippedAbove:(LKFloat)highest {
	return [self clippedBelow:LKNegativeInfinity above:highest];
}


- (LKOperation *)clippedBelow:(LKFloat)lowest above:(LKFloat)highest {
    if (lowest > highest) {
        return [LKOperation fill:NAN];
    }
    else {
        return [self operation:^(LKVector *destination, LKUInteger length) {
            LK_vDSP(vclip)(LKUnwrap(self), &lowest, &highest, LKUnwrap(destination), length);
        }];
    }
}



- (void)clipTo:(LKVector *)destination below:(LKFloat)lowest count:(out LKInteger *)below above:(LKFloat)highest count:(out LKInteger *)above {
    __block LKUInteger unsignedBelow = 0;
    __block LKUInteger unsignedAbove = 0;
    
    [destination set:[self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vclipc)(LKUnwrap(self), &lowest, &highest, LKUnwrap(destination), length, &unsignedBelow, &unsignedAbove);
    }]];
    
    *below = LKSigned(unsignedBelow);
    *above = LKSigned(unsignedAbove);
}



- (LKOperation *)invertClippedAbove:(LKFloat)lowest below:(LKFloat)highest {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(viclip)(LKUnwrap(self), &lowest, &highest, LKUnwrap(destination), length);
    }];
}



- (LKOperation *)clearedBelow:(LKFloat)lowest {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vthres)(LKUnwrap(self), &lowest, LKUnwrap(destination), length);
    }];
}



#pragma mark Comparisons


- (LKOperation *)comparedTo:(LKFloat)limit {
    return [self comparedTo:limit mark:1];
}


- (LKOperation *)comparedTo:(LKFloat)limit mark:(LKFloat)value {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vlim)(LKUnwrap(self), &limit, &value, LKUnwrap(destination), length);
        //ALT: vDSP_vthrsc
    }];
}



#pragma mark Extremes


- (LKOperation *)maximumWith:(LKVector *)other {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vmax)(LKUnwrap(self), LKUnwrap(other), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)minimumWith:(LKVector *)other {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vmin)(LKUnwrap(self), LKUnwrap(other), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)maximumMagnitudesWith:(LKVector *)other {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vmaxmg)(LKUnwrap(self), LKUnwrap(other), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)minimumMagnitudesWith:(LKVector *)other {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vminmg)(LKUnwrap(self), LKUnwrap(other), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)slidingWindowMaximum:(LKInteger)window {
    LKVector *subself = [self subvectorWithLength:self.length - window + 1];
    return [subself operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vswmax)(LKUnwrap(self), LKUnwrap(destination), length, LKUnsigned(window));
    }];
}



@end


