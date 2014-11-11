//
//  LKVector+Miscellaneous.m
//  LinearKit
//
//  Created by Martin Kiss on 27.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Miscellaneous.h"
#import "LKPrivate.h"



@implementation LKVector (Miscellaneous)



- (LKOperation *)fractions {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vfrac)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}



- (LKOperation *)selected:(LKVector *)indexes {
    return [self selected:indexes interpolate:NO];
}


- (LKOperation *)selected:(LKVector *)indexes interpolate:(BOOL)interpolate {
    LKVector *linearized = [self linearized]; //! This operation does not respect strides of Subvectors.
    if (interpolate) {
        //! Creating operation using indexes vector, so lengths match.
        return [indexes operation:^(LKVector *destination, LKUInteger length) {
            LK_vDSP(vlint)(linearized.head, LKUnwrap(indexes), LKUnwrap(destination), length, LKUnsigned(linearized.length));
        }];
    }
    else {
        //! Creating operation using indexes vector, so lengths match.
        return [indexes operation:^(LKVector *destination, LKUInteger length) {
            LK_vDSP(vindex)(linearized.head, LKUnwrap(indexes), LKUnwrap(destination), length);
        }];
    }
}



- (LKOperation *)compressed {
    return [self compressedWithGate:self];
}


- (LKOperation *)compressedWithGate:(LKVector *)gate {
    //TODO: Get the final length somewhow?
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vcmprs)(LKUnwrap(self), LKUnwrap(gate), LKUnwrap(destination), length);
    }];
}



- (LKInteger)findNumberOfZeroCrossings {
    return [self findZeroCrossingsWithMaxCount:LKIntegerMax lastIndex:NULL];
}


- (LKInteger)indexOfZeroCrossing:(LKInteger)crossing {
    LKInteger index = LKIndexNotFound;
    LKInteger count = [self findZeroCrossingsWithMaxCount:(crossing + 1) lastIndex:&index];
    return (crossing < count? index : LKIndexNotFound);
}


- (LKInteger)findZeroCrossingsWithMaxCount:(LKInteger)max lastIndex:(out LKInteger *)last {
    LKUInteger count = 0;
    LKUInteger index = 0;
    vDSP_nzcros(LKUnwrap(self), LKUnsigned(max), &index, &count, LKUnsigned(self.length));
    if (last) *last = LKSigned(index);
    return LKSigned(count);
}



- (LKOperation *)runningSumIntegration:(LKFloat)weight {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vrsum)(LKUnwrap(self), &weight, LKUnwrap(destination), length);
    }];
}


- (LKOperation *)simpsonIntegration:(LKFloat)step {
    //TODO: Only out of place.
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vsimps)(LKUnwrap(self), &step, LKUnwrap(destination), length);
    }];
}


- (LKOperation *)trapezoidalIntegration:(LKFloat)step {
    //TODO: Only out of place.
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vsimps)(LKUnwrap(self), &step, LKUnwrap(destination), length);
        vDSP_vtrapz(LKUnwrap(self), &step, LKUnwrap(destination), length);
    }];
}



- (void)sortAscending:(BOOL)ascending {
    LKVector *linearized = [self linearized];
    LK_vDSP(vsort)(linearized.head, LKUnsigned(linearized.length), (ascending? 1 : -1));
    [self set:linearized];
}



- (LKOperation *)slidingWindowSum:(LKInteger)window {
    LKVector *subself = [self subvectorWithLength:self.length - window + 1];
    return [subself operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vswsum)(LKUnwrap(self), LKUnwrap(destination), length, LKUnsigned(window));
    }];
}



@end


