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





NSString * const LKIndexException = @"LKIndexException";


NSException * LKException(NSString *name, NSString *format, ...) {
    va_list vargs;
    va_start(vargs, format);
    NSString *reason = [[NSString alloc] initWithFormat:format arguments:vargs];
    va_end(vargs);
    return [NSException exceptionWithName:name reason:reason userInfo:nil];
}


void LKAssertIndex(LKVector *vector, LKIndex index) {
    if (index >= vector.length) {
        @throw LKException(LKIndexException, @"Index %lu out of bounds for %@", index, vector.debugDescription);
    }
}





LKFloat const LKZero = 0;
LKFloat const LKEpsion = LKPrecision(FLT_EPSILON, DBL_EPSILON);
LKFloat const LKOne = 1;
LKFloat const LKInfinity = INFINITY;
LKFloat const LKNAN = NAN;





NSUInteger LKHash(LKFloat value) {
    // Taken from _CFHashDouble() at http://www.opensource.apple.com/source/CF/CF-550/ForFoundationOnly.h
    LKFloat absolute = ABS(value);
    LKFloat integral = LK_f(round)(absolute);
    LKFloat fragment = absolute - integral;
    NSUInteger integralHash = 2654435761U * LK_f(fmod)(integral, NSUIntegerMax);
    NSUInteger fragmentHash = fragment * NSUIntegerMax;
    return integralHash + fragmentHash;
}


