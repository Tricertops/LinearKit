//
//  LKVector+Generating.m
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Generating.h"
#import "LKPrivate.h"



@implementation LKVector (Generating)



- (void)clear {
    [self set:[LKOperation clear]];
}


- (void)fill:(LKFloat)constant {
	[self set:[LKOperation fill:constant]];
}


- (void)rampFrom:(LKFloat)first by:(LKFloat)step {
	[self set:[LKOperation rampFrom:first by:step]];
}


- (void)interpolateFrom:(LKFloat)first to:(LKFloat)last {
	[self set:[LKOperation interpolateFrom:first to:last]];
}



@end



#pragma mark -

@implementation LKOperation (Generators)




+ (LKOperation *)clear {
    return [LKOperation operationWithLength:LKIntegerMax block:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vclr)(LKUnwrap(destination), length);
    }];
}


+ (LKOperation *)fill:(LKFloat)constant {
    if (constant == 0) {
        return [self clear];
    }
    else {
        return [LKOperation operationWithLength:LKIntegerMax block:^(LKVector *destination, LKUInteger length) {
            LK_vDSP(vfill)(&constant, LKUnwrap(destination), length);
        }];
    }
}


+ (LKOperation *)rampFrom:(LKFloat)first by:(LKFloat)step {
    if (step == 0) {
        return [self fill:first];
    }
    else {
        return [LKOperation operationWithLength:LKIntegerMax block:^(LKVector *destination, LKUInteger length) {
            LK_vDSP(vramp)(&first, &step, LKUnwrap(destination), length);
        }];
    }
}


+ (LKOperation *)interpolateFrom:(LKFloat)first to:(LKFloat)last {
    if (first == last) {
        return [self fill:first];
    }
    else {
        return [LKOperation operationWithLength:LKIntegerMax block:^(LKVector *destination, LKUInteger length) {
            LK_vDSP(vgen)(&first, &last, LKUnwrap(destination), length);
        }];
    }
}



@end


