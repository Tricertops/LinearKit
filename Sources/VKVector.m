//
//  VKVector.m
//  VectorKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKPrivateVector.h"



@implementation VKVector



@dynamic values;
@dynamic stride;
@dynamic length;



- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (NSUInteger)hash {
    return (NSUInteger)self.values ^ self.stride ^ self.length;
}


- (BOOL)isEqual:(VKVector *)other {
    if (self == other) return YES;
    if ( ! [other isKindOfClass:[VKVector class]]) return NO;
    return (   self.values == other.values
            && self.stride == other.stride
            && self.length == other.length);
}



@end


