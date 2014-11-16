//
//  LKVector+Arithmetics.m
//  LinearKit
//
//  Created by Martin Kiss on 13.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Arithmetics.h"
#import "LKVector+Signs.h"
#import "LKPrivate.h"
#import "NSNumber.h"





@implementation LKVector (Arithmetics)



#pragma mark Single Operation


- (LKOperation *)singleOperand:(id<LKArithmetic>)operand scalar:(LKOperation *(^)(LKFloat scalar))scalarBlock vector:(LKOperation *(^)(LKVector *vector))vectorBlock {
    if ([operand respondsToSelector:@selector(LK_floatValue)]) {
        LKFloat scalar = [operand LK_floatValue];
        return scalarBlock(scalar);
    }
    else if ([operand isKindOfClass:[LKVector class]]) {
        LKVector *vector = (LKVector *)operand;
        return vectorBlock(vector);
    }
    else {
        @throw LKException(LKArithmeticException, @"Unsupported oeprand: %@", operand);
    }
}


- (LKOperation *)addedTo:(id<LKArithmetic>)other {
    return [self singleOperand:other
                        scalar:^LKOperation *(LKFloat scalar) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vsadd)(LKUnwrap(self), &scalar, LKUnwrap(destination), length);
                            }];
                        }
                        vector:^LKOperation *(LKVector *vector) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vadd)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                            }];
                        }];
}


- (LKOperation *)subtracted:(id<LKArithmetic>)other {
    return [self singleOperand:other
                        scalar:^LKOperation *(LKFloat scalar) {
                            return [self addedTo:@(-scalar)];
                        }
                        vector:^LKOperation *(LKVector *vector) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vsub)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                            }];
                        }];
}


- (LKOperation *)subtractedFrom:(id<LKArithmetic>)other {
    return [self singleOperand:other
                        scalar:^LKOperation *(LKFloat scalar) {
                            // There is no dedicated function for scalar-vector subtraction?
                            return [[[self negated] vectorize] addedTo:@(scalar)];
                        }
                        vector:^LKOperation *(LKVector *vector) {
                            return [vector subtracted:self];
                        }];
}


- (LKOperation *)multipliedBy:(id<LKArithmetic>)other {
    return [self singleOperand:other
                        scalar:^LKOperation *(LKFloat scalar) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vsmul)(LKUnwrap(self), &scalar, LKUnwrap(destination), length);
                            }];
                        }
                        vector:^LKOperation *(LKVector *vector) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vmul)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                            }];
                        }];
}


- (LKOperation *)dividedBy:(id<LKArithmetic>)other {
    return [self singleOperand:other
                        scalar:^LKOperation *(LKFloat scalar) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vsdiv)(LKUnwrap(self), &scalar, LKUnwrap(destination), length);
                            }];
                        }
                        vector:^LKOperation *(LKVector *vector) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(vdiv)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                            }];
                        }];
}


- (LKOperation *)dividing:(id<LKArithmetic>)other {
    return [self singleOperand:other
                        scalar:^LKOperation *(LKFloat scalar) {
                            return [self operation:^(LKVector *destination, LKUInteger length) {
                                LK_vDSP(svdiv)(&scalar, LKUnwrap(self), LKUnwrap(destination), length);
                            }];
                        }
                        vector:^LKOperation *(LKVector *vector) {
                            return [vector dividedBy:self];
                        }];
}





#pragma mark Multiply


- (LKOperation *)multipliedByRampFrom:(LKFloat)first by:(const LKFloat)step {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LKFloat start = first; // In-out argument, will be modified by the function.
        vDSP_vrampmul(LKUnwrap(self), &start, &step, LKUnwrap(destination), length);
    }];
}



#pragma mark Squares


- (LKOperation *)squared {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vsq)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)signedSquared {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vssq)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}



@end

