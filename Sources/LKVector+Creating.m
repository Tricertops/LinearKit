//
//  LKVector+Creating.m
//  LinearKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"





@implementation LKVector (Creating)



+ (LKVector *)vectorWithLength:(LKLength)length {
    NSMutableData *data = [NSMutableData dataWithLength:length * sizeof(LKFloat)];
    return [[LKVector alloc] initWithMutableData:data];
}


- (LKVector *)initWithMutableData:(NSMutableData *)data {
    return [[LKSteadyVector alloc] initWithMutableData:data];
}



- (LKVector *)copy {
    LKVector *vector = [LKVector vectorWithLength:self.length];
    [vector setValues:self];
    return vector;
}


- (LKVector *)copyWithZone:(__unused NSZone *)zone {
    return [self copyWithZone:NULL];
}



@end


