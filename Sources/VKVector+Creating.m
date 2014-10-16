//
//  VKVector+Creating.m
//  VectorKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKVector+Private.h"
#import "VKSteadyVector.m"





@implementation VKVector (Creating)



+ (VKVector *)vectorWithLength:(VKLength)length {
    return [[VKVector alloc] initWithValues:NULL length:length];
}


- (VKVector *)initWithValues:(const VKFloat [])values length:(VKLength)length {
    return [[VKSteadyVector alloc] initWithValues:values length:length];
}



- (VKVector *)copy {
    return [super copy];
}


- (VKVector *)copyWithZone:(NSZone *)zone {
    return [[VKVector alloc] initWithValues:self.values length:self.length];
}



@end


