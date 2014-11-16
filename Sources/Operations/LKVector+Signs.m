//
//  LKVector+Signs.m
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Signs.h"
#import "LKPrivate.h"
#import "LKVector+Limits.h"





@implementation LKVector (Signs)



- (LKOperation *)absolute {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vabs)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)negativeAbsolute {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vnabs)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)signs {
    return [self comparedTo:0];
}



@end


