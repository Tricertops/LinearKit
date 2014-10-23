//
//  LKOperationVector.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKOperation.h"



@implementation LKOperation


//TODO: Block taking destination.
//TODO: Support variable length operations.


- (LKVector *)vectorize {
    LKVector *vector = [LKVector vectorWithLength:self.length];
    [self fillVector:vector];
    return vector;
}


- (LKOperation *)copy {
    //TODO: Copy block
    return nil;
}


- (LKVector *)copyWithZone:(__unused NSZone *)zone {
    return [self copy];
}


- (void)fillVector:(LKVector *)vector {
    //TODO: Check lengths
    //TODO: Invoke block
}





@end


