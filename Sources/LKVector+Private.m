//
//  LKVector+Private.m
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"



@implementation LKVector

@end





@implementation LKVector (Private)



- (instancetype)initSubclass {
    return [super init];
}


- (LKFloat *)head {
    return NULL;
}


- (LKStride)stride {
    return 0;
}


- (LKLength)length {
    return 0;
}



@end





LKFloat const LKZero = 0;
LKFloat const LKOne = 1;


