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
    __block NSUInteger hash = self.length;
    [self enumerateValuesConcurrently:NO usingBlock:^(LKIndex index, LKFloat value) {
        hash ^= LKHash(value);
    }];
    return hash;
}


- (BOOL)isEqual:(LKVector *)other {
    if (self == other) return YES;
    if ( ! [other isKindOfClass:[LKVector class]]) return NO;
    if (self.length != other.length) return NO;
    
    LKLength length = MIN(self.length, other.length);
    for (LKIndex index = 0; index < length; index++) {
        LKFloat my = [self valueAtIndex:index];
        LKFloat his = [other valueAtIndex:index];
        if (my != his) {
            return NO;
        }
    }
    return YES;
}



@end


