//
//  LKVector+Accessing.m
//  LinearKit
//
//  Created by Martin Kiss on 17.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"




@implementation LKVector (Accessing)



- (LKFloat)valueAtIndex:(LKInteger)index {
    [self validateIndex:index];
    return self.head[index * self.stride];
}


- (void)setValue:(LKFloat)value atIndex:(LKInteger)index {
    [self validateIndex:index];
    self.head[index * self.stride] = value;
}


- (LKFloat *(^)(LKInteger))at {
    return ^LKFloat*(LKInteger index){
        [self validateIndex:index];
        return self.head + (index * self.stride);
    };
}



- (void)enumerateConcurrently:(BOOL)concurrently block:(void (^)(LKInteger, LKFloat *))block {
    LKFloat* head = self.head;
    LKInteger stride = self.stride;
    LKInteger length = self.length;
    
    if (concurrently) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(LKUnsigned(length), queue, ^(size_t index){
            LKInteger signedIndex = LKSigned(index);
            block(signedIndex, head + (signedIndex * stride));
        });
    }
    else {
        for (LKInteger index = 0; index < length; index++) {
            block(index, head + (index * stride));
        }
    }
}



@end
