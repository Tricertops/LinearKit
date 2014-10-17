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
    return [[NSClassFromString(@"LKSteadyVector") alloc] initWithMutableData:data];
}



- (LKVector *)copy {
    return [super copy];
}


- (LKVector *)copyWithZone:(NSZone *)zone {
    //TODO: Wrong, must use striding.
    return nil;
}



@end


