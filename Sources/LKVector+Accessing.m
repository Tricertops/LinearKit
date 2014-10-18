//
//  LKVector+Accessing.m
//  LinearKit
//
//  Created by Martin Kiss on 17.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"




@implementation LKVector (Accessing)



- (LKFloat)valueAtIndex:(LKIndex)index {
    LKAssertIndex(self, index);
    return self.head[(LKStride)index * self.stride];
}


- (void)setValue:(LKFloat)value atIndex:(LKIndex)index {
    LKAssertIndex(self, index);
    self.head[(LKStride)index * self.stride] = value;
}


- (LKFloat *(^)(LKIndex))at {
    return ^LKFloat*(LKIndex index){
        LKAssertIndex(self, index);
        return self.head + ((LKStride)index * self.stride);
    };
}



- (void)enumerateConcurrently:(BOOL)concurrently block:(void (^)(LKIndex, LKFloat *))block {
    LKFloat* head = self.head;
    LKStride stride = self.stride;
    LKLength length = self.length;
    
    if (concurrently) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(length, queue, ^(size_t index){
            block(index, head + ((LKStride)index * stride));
        });
    }
    else {
        for (LKIndex index = 0; index < length; index++) {
            block(index, head + ((LKStride)index * stride));
        }
    }
}



@end
