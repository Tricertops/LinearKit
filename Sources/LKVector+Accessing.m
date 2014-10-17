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
    return self.head[index * self.stride];
}


- (void)enumerateValuesConcurrently:(BOOL)concurrently usingBlock:(void(^)(LKIndex index, LKFloat value))block {
    LKFloat* head = self.head;
    LKStride stride = self.stride;
    LKLength length = self.length;
    
    if (concurrently) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_apply(length, queue, ^(size_t index){
            block(index, head[index * stride]);
        });
    }
    else {
        for (LKIndex index = 0; index < length; index++) {
            block(index, head[index * stride]);
        }
    }
}


- (void)transformValuesConcurrently:(BOOL)concurrently usingBlock:(LKFloat(^)(LKIndex index, LKFloat value))block {
    LKFloat* head = self.head;
    LKStride stride = self.stride;
    
    [self enumerateValuesConcurrently:concurrently usingBlock:^(LKIndex index, LKFloat value) {
        LKFloat* reference = head + (index * stride);
        *reference = block(index, *reference);
    }];
}



@end
