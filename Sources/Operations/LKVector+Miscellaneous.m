//
//  LKVector+Miscellaneous.m
//  LinearKit
//
//  Created by Martin Kiss on 27.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Miscellaneous.h"
#import "LKPrivate.h"



@implementation LKVector (Miscellaneous)



- (LKOperation *)fractions {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vfrac)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}



- (LKOperation *)select:(LKVector *)indexes {
    //TODO: Subvector must be linearized.
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vindex)(self.head, LKUnwrap(indexes), LKUnwrap(destination), length);
    }];
}



@end


