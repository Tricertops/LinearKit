//
//  LKVector+Subvector.m
//  LinearKit
//
//  Created by Martin Kiss on 18.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"





@implementation LKVector (Subvector)



- (LKVector *)subvectorFrom:(LKInteger)start {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:1 length:self.length - start];
}


- (LKVector *)subvectorTo:(LKInteger)end {
    return [[LKSubvector alloc] initWithSource:self offset:0 stride:1 length:(end + 1)];
}


- (LKVector *)subvectorWithLength:(LKInteger)length {
    return [[LKSubvector alloc] initWithSource:self offset:0 stride:1 length:length];
}


- (LKVector *)subvectorBy:(LKInteger)stride {
    return [[LKSubvector alloc] initWithSource:self offset:0 stride:stride length:ceil((LKFloat)self.length / stride)];
}


- (LKVector *)subvectorFrom:(LKInteger)start to:(LKInteger)end {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:1 length:(end + 1) - start];
}


- (LKVector *)subvectorFrom:(LKInteger)start length:(LKInteger)length {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:1 length:length];
}


- (LKVector *)subvectorFrom:(LKInteger)start by:(LKInteger)stride {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:stride length:ceil((LKFloat)(self.length-start) / stride)];
}


- (LKVector *)reversedVector {
    return [[LKSubvector alloc] initWithSource:self offset:(self.length - 1) stride:-1 length:self.length];
}



@end


