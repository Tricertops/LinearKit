//
//  NSNumber.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "NSNumber.h"



@implementation NSNumber (LinearKit)



- (LKFloat)LK_floatValue {
    return LKPrecision([self floatValue], [self doubleValue]);
}



@end


