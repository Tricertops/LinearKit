//
//  VKVector.m
//  VectorKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKVector+Private.h"



@implementation VKVector



@dynamic values;
@dynamic stride;
@dynamic length;



- (instancetype)initSubclass {
    return [super init];
}


- (VKFloat *)values {
    return NULL;
}


- (VKStride)stride {
    return 0;
}


- (VKLength)length {
    return 0;
}



@end





@implementation VKVector (Equality)



- (NSUInteger)hash {
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


