//
//  LKVector+Private.m
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"



@implementation LKVector



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





VKFloat const VKZero = 0;
VKFloat const VKOne = 1;


