//
//  LKVector+Arithmetics.m
//  LinearKit
//
//  Created by Martin Kiss on 13.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Arithmetics.h"
#import "LKPrivate.h"
#import "NSNumber.h"





@implementation LKVector (Arithmetics)



#pragma mark Multiply


- (LKOperation *)multipliedByRampFrom:(LKFloat)first by:(const LKFloat)step {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LKFloat start = first; // In-out argument, will be modified by the function.
        vDSP_vrampmul(LKUnwrap(self), &start, &step, LKUnwrap(destination), length);
    }];
}



#pragma mark Squares


- (LKOperation *)squared {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vsq)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)signedSquared {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vssq)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}



@end


