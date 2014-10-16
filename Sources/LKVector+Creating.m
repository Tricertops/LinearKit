//
//  LKVector+Creating.m
//  LinearKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"
#import "LKSteadyVector.m"





@implementation LKVector (Creating)



+ (LKVector *)vectorWithLength:(VKLength)length {
    return [[LKVector alloc] initWithValues:NULL length:length];
}


- (LKVector *)initWithValues:(const VKFloat [])values length:(VKLength)length {
    return [[LKSteadyVector alloc] initWithValues:values length:length];
}



- (LKVector *)copy {
    return [super copy];
}


- (LKVector *)copyWithZone:(NSZone *)zone {
    return [[LKVector alloc] initWithValues:self.values length:self.length];
}



@end


