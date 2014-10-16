//
//  VKVector+Equality.m
//  VectorKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKVector+Private.h"





@implementation VKVector (Equality)



- (NSUInteger)hash {
    //TODO: Include values, at least few first and few last
    return (NSUInteger)self.values ^ self.stride ^ self.length;
}


- (BOOL)isEqual:(VKVector *)other {
    if (self == other) return YES;
    if ( ! [other isKindOfClass:[VKVector class]]) return NO;
    
    //TODO: Compare actual values
    return (   self.values == other.values
            && self.stride == other.stride
            && self.length == other.length);
}



@end


