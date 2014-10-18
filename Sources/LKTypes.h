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




typedef unsigned long LKIndex;
typedef LKIndex LKLength;
typedef LKIndex LKOffset;
typedef long LKStride;

typedef LKPrecision(float, double) LKFloat;


extern LKFloat const LKZero;
extern LKFloat const LKEpsion;
extern LKFloat const LKOne;
extern LKFloat const LKInfinity;
extern LKFloat const LKNAN;


extern NSUInteger LKHash(LKFloat);


