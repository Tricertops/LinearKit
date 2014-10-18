//
//  LKVector+Equality.m
//  LinearKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"





@implementation LKVector (Equality)



- (NSUInteger)hash {
    __block NSUInteger hash = LKUnsigned(self.length) * 2654435761U;
    [self enumerateConcurrently:NO block:^(__unused LKInteger index, LKFloat *reference) {
        hash ^= LKHash(*reference);
    }];
    return hash;
}


- (BOOL)isEqual:(LKVector *)other {
    return [self isEqual:other epsilon:0];
}


- (BOOL)isEqual:(LKVector *)other epsilon:(LKFloat)epsilon {
    if (self == other) return YES;
    if ( ! [other isKindOfClass:[LKVector class]]) return NO;
    if (self.length != other.length) return NO;
    
    LKFloat* myHead = self.head;
    LKInteger myStride = self.stride;
    LKFloat* hisHead = other.head;
    LKInteger hisStride = other.stride;
    
    LKInteger length = MIN(self.length, other.length);
    for (LKInteger index = 0; index < length; index++) {
        LKFloat my = myHead[index * myStride];
        LKFloat his = hisHead[index * hisStride];
        
        if (isnan(my) && isnan(his)) continue;
        if (ABS(my - his) > epsilon) return NO;
    }
    return YES;
}



@end


