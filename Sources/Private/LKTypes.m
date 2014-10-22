//
//  LKTypes.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKPrivate.h"



LKFloat const LKZero = 0;
LKFloat const LKEpsion = LKPrecision(FLT_EPSILON, DBL_EPSILON);
LKFloat const LKOne = 1;
LKFloat const LKInfinity = INFINITY;
LKFloat const LKNAN = NAN;

LKUInteger const LKHashFactor = 2654435761U;
LKInteger const LKIntegerMax = LONG_MAX;



NSUInteger LKHash(LKFloat value) {
    // Taken from _CFHashDouble() at http://www.opensource.apple.com/source/CF/CF-550/ForFoundationOnly.h
    LKFloat absolute = ABS(value);
    LKFloat integral = LK_f(round)(absolute);
    LKFloat fragment = absolute - integral;
    NSUInteger integralHash = LKHashFactor * LK_f(fmod)(integral, NSUIntegerMax);
    NSUInteger fragmentHash = fragment * NSUIntegerMax;
    return integralHash + fragmentHash;
}



NSString * const LKIndexException = @"LKIndexException";


NSException * LKException(NSString *name, NSString *format, ...) {
    va_list vargs;
    va_start(vargs, format);
    NSString *reason = [[NSString alloc] initWithFormat:format arguments:vargs];
    va_end(vargs);
    return [NSException exceptionWithName:name reason:reason userInfo:nil];
}



LKUInteger LKUnsigned(LKInteger integer) {
    if (integer < 0) @throw LKException(LKIndexException, @"This integer must not be negative.");
    return (LKUInteger)integer;
}


LKInteger LKSigned(LKUInteger integer) {
    if (integer > LKIntegerMax) @throw LKException(LKIndexException, @"This integer is too large.");
    return (LKInteger)integer;
}


