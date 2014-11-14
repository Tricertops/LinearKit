//
//  LKTypes.h
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import Foundation;
@import Accelerate;
#import "LKPrecision.h"


#pragma mark - Integers

typedef long LKInteger;
typedef unsigned long LKUInteger;
extern LKInteger const LKIntegerMax;
extern LKInteger const LKIndexNotFound;
extern LKUInteger LKUnsigned(LKInteger);
extern LKInteger LKSigned(LKUInteger);


#pragma mark - Floats

typedef LKPrecision(float, double) LKFloat;

extern LKFloat const LKZero;
extern LKFloat const LKEpsion;
extern LKFloat const LKOne;
extern LKFloat const LKInfinity;
extern LKFloat const LKNegativeInfinity;
extern LKFloat const LKNAN;


#pragma mark - Hashing

extern NSUInteger LKHash(LKFloat);
extern LKUInteger const LKHashFactor;


#pragma mark -

@class LKVector;

@protocol LKSource <NSObject, NSCopying>

- (instancetype)copy;
- (void)fillVector:(LKVector *)vector;

@end

@protocol LKArithmetic <NSObject>

@optional
- (LKFloat)LK_floatValue;

@end



#pragma mark - Blocks

typedef void(^LKOperationBlock)(LKVector *destination, LKUInteger length);


