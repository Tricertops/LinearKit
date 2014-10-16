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
    //TODO: Include values, at least few first and few last
    return (NSUInteger)self.values ^ self.stride ^ self.length;
}


- (BOOL)isEqual:(LKVector *)other {
    if (self == other) return YES;
    if ( ! [other isKindOfClass:[LKVector class]]) return NO;
    
    //TODO: Compare actual values
    return (   self.values == other.values
            && self.stride == other.stride
            && self.length == other.length);
}



@end


