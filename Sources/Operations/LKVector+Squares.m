//
//  LKVector+Squares.m
//  LinearKit
//
//  Created by Martin Kiss on 27.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Squares.h"
#import "LKPrivate.h"



@implementation LKVector (Squares)



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


