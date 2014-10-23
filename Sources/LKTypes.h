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



typedef long LKInteger;
typedef unsigned long LKUInteger;
extern LKInteger const LKIntegerMax;
extern LKUInteger LKUnsigned(LKInteger);
extern LKInteger LKSigned(LKUInteger);


typedef LKPrecision(float, double) LKFloat;
extern LKFloat const LKZero;
extern LKFloat const LKEpsion;
extern LKFloat const LKOne;
extern LKFloat const LKInfinity;
extern LKFloat const LKNAN;


extern NSUInteger LKHash(LKFloat);
extern LKUInteger const LKHashFactor;



@class LKVector;

@protocol LKSource <NSObject, NSCopying>

- (instancetype)copy;
- (void)fillVector:(LKVector *)vector;

@end



typedef void(^LKOperationBlock)(LKVector *destination, LKUInteger length);
typedef void(^LKGeneratorBlock)(LKVector *destination);
typedef LKFloat(^LKGeneratorIndexBlock)(LKInteger index, LKInteger length);


