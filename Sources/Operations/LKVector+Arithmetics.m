//
//  LKVector+Arithmetics.m
//  LinearKit
//
//  Created by Martin Kiss on 13.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Arithmetics.h"
#import "LKVector+Limits.h"
#import "LKPrivate.h"
#import "NSNumber.h"





@implementation LKVector (Arithmetics)





#pragma mark Signed Operations


- (LKOperation *)signs {
    return [self comparedTo:0];
}


- (LKOperation *)negated {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vneg)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)absolute {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vabs)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}


- (LKOperation *)negativeAbsolute {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(vnabs)(LKUnwrap(self), LKUnwrap(destination), length);
    }];
}



#pragma mark Helpers


- (LKOperation *)operand:(id<LKArithmetic>)operand scalar:(LKOperation *(^)(LKFloat scalar))scalarBlock vector:(LKOperation *(^)(LKVector *vector))vectorBlock {
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



#pragma mark Addition & Subtraction


- (LKOperation *)addedTo:(id<LKArithmetic>)other {
    return [self operand:other
                  scalar:^LKOperation *(LKFloat scalar) {
                      if (scalar == 0) {
                          return [LKOperation wrap:self]; // No-op.
                      }
                      else {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsadd)(LKUnwrap(self), &scalar, LKUnwrap(destination), length);
                          }];
                      }
                  }
                  vector:^LKOperation *(LKVector *vector) {
                      return [self operation:^(LKVector *destination, LKUInteger length) {
                          LK_vDSP(vadd)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                      }];
                  }];
}


- (LKOperation *)subtracted:(id<LKArithmetic>)other {
    return [self operand:other
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
    return [self operand:other
                  scalar:^LKOperation *(LKFloat scalar) {
                      if (scalar == 0) {
                          return [LKOperation wrap:self]; // No-op.
                      }
                      else {
                          // There is no dedicated function for scalar-vector subtraction?
                          return [[[self negated] vectorize] addedTo:@(scalar)];
                      }
                  }
                  vector:^LKOperation *(LKVector *vector) {
                      return [vector subtracted:self];
                  }];
}



#pragma mark Multiplication & Division


- (LKOperation *)inverted {
    return [self dividing:@1];
}


- (LKOperation *)multipliedBy:(id<LKArithmetic>)other {
    return [self operand:other
                  scalar:^LKOperation *(LKFloat scalar) {
                      // Cannot simplify for 0, because it may yield NaN for infinity.
                      if (scalar == 1) {
                          return [LKOperation wrap:self]; // No-op.
                      }
                      else if (scalar == -1) {
                          return [self negated];
                      }
                      else {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsmul)(LKUnwrap(self), &scalar, LKUnwrap(destination), length);
                          }];
                      }
                  }
                  vector:^LKOperation *(LKVector *vector) {
                      return [self operation:^(LKVector *destination, LKUInteger length) {
                          LK_vDSP(vmul)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                      }];
                  }];
}


- (LKOperation *)dividedBy:(id<LKArithmetic>)other {
    return [self operand:other
                  scalar:^LKOperation *(LKFloat scalar) {
                      // Cannot simplify for 0, because it may yield NaN for infinity.
                      if (scalar == 1) {
                          return [LKOperation wrap:self]; // No-op.
                      }
                      else if (scalar == -1) {
                          return [self negated];
                      }
                      else {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsdiv)(LKUnwrap(self), &scalar, LKUnwrap(destination), length);
                          }];
                      }
                  }
                  vector:^LKOperation *(LKVector *vector) {
                      return [self operation:^(LKVector *destination, LKUInteger length) {
                          LK_vDSP(vdiv)(LKUnwrap(self), LKUnwrap(vector), LKUnwrap(destination), length);
                      }];
                  }];
}


- (LKOperation *)dividing:(id<LKArithmetic>)other {
    return [self operand:other
                  scalar:^LKOperation *(LKFloat scalar) {
                      return [self operation:^(LKVector *destination, LKUInteger length) {
                          LK_vDSP(svdiv)(&scalar, LKUnwrap(self), LKUnwrap(destination), length);
                      }];
                  }
                  vector:^LKOperation *(LKVector *vector) {
                      return [vector dividedBy:self];
                  }];
}


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


- (LKOperation *)multipliedByRampFrom:(LKFloat)first by:(const LKFloat)step {
    return [self operation:^(LKVector *destination, LKUInteger length) {
        LKFloat start = first; // In-out argument, will be modified by the function.
        LK_vDSP(vrampmul)(LKUnwrap(self), &start, &step, LKUnwrap(destination), length);
    }];
}



#pragma mark Combined


- (LKOperation *)addedTo:(id<LKArithmetic>)first multipliedBy:(id<LKArithmetic>)second {
    return [self operand:first scalar:^LKOperation *(LKFloat first) {
        if (first == 0) {
            return [self multipliedBy:second];
        }
        else {
            return [[[self addedTo:@(first)] vectorize] multipliedBy:second];
        }
    } vector:^LKOperation *(LKVector *first) {
        return [self operand:second
                      scalar:^LKOperation *(LKFloat second) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vasm)(LKUnwrap(self), LKUnwrap(first), &second, LKUnwrap(destination), length);
                          }];
                      }
                      vector:^LKOperation *(LKVector *second) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vam)(LKUnwrap(self), LKUnwrap(first), LKUnwrap(second), LKUnwrap(destination), length);
                          }];
                      }];
    }];
}


- (LKOperation *)subtracted:(id<LKArithmetic>)first multipliedBy:(id<LKArithmetic>)second {
    return [self operand:first scalar:^LKOperation *(LKFloat first) {
        return [self addedTo:@(-first) multipliedBy:second];
    } vector:^LKOperation *(LKVector *first) {
        return [self operand:second
                      scalar:^LKOperation *(LKFloat second) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsbsm)(LKUnwrap(self), LKUnwrap(first), &second, LKUnwrap(destination), length);
                          }];
                      }
                      vector:^LKOperation *(LKVector *second) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsbm)(LKUnwrap(self), LKUnwrap(first), LKUnwrap(second), LKUnwrap(destination), length);
                          }];
                      }];
    }];
}


- (LKOperation *)subtractedFrom:(id<LKArithmetic>)first multipliedBy:(id<LKArithmetic>)second {
    return [self operand:first scalar:^LKOperation *(LKFloat first) {
        return [[[self subtractedFrom:@(first)] vectorize] multipliedBy:second];
    } vector:^LKOperation *(LKVector *first) {
        return [self operand:second
                      scalar:^LKOperation *(LKFloat second) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsbsm)(LKUnwrap(first), LKUnwrap(self), &second, LKUnwrap(destination), length);
                          }];
                      }
                      vector:^LKOperation *(LKVector *second) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsbm)(LKUnwrap(first), LKUnwrap(self), LKUnwrap(second), LKUnwrap(destination), length);
                          }];
                      }];
    }];
}


- (LKOperation *)multipliedBy:(id<LKArithmetic>)first addedTo:(id<LKArithmetic>)second {
    return [self operand:first scalar:^LKOperation *(LKFloat first) {
        return [self operand:second scalar:^LKOperation *(LKFloat second) {
            return [self operation:^(LKVector *destination, LKUInteger length) {
                LK_vDSP(vsmsa)(LKUnwrap(self), &first, &second, LKUnwrap(destination), length);
            }];
        } vector:^LKOperation *(LKVector *second) {
            return [self operation:^(LKVector *destination, LKUInteger length) {
                LK_vDSP(vsma)(LKUnwrap(self), &first, LKUnwrap(second), LKUnwrap(destination), length);
            }];
        }];
    } vector:^LKOperation *(LKVector *first) {
        return [self operand:second scalar:^LKOperation *(LKFloat second) {
            return [self operation:^(LKVector *destination, LKUInteger length) {
                LK_vDSP(vmsa)(LKUnwrap(self), LKUnwrap(first), &second, LKUnwrap(destination), length);
            }];
        } vector:^LKOperation *(LKVector *second) {
            return [self operation:^(LKVector *destination, LKUInteger length) {
                LK_vDSP(vma)(LKUnwrap(self), LKUnwrap(first), LKUnwrap(second), LKUnwrap(destination), length);
            }];
        }];
    }];
}


- (LKOperation *)multipliedBy:(id<LKArithmetic>)first subtracted:(id<LKArithmetic>)second {
    return [self operand:second scalar:^LKOperation *(LKFloat second) {
        return [self multipliedBy:first addedTo:@(-second)];
    } vector:^LKOperation *(LKVector *second) {
        return [self operand:first
                      scalar:^LKOperation *(LKFloat first) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vsmsb)(LKUnwrap(self), &first, LKUnwrap(second), LKUnwrap(destination), length);
                          }];
                      }
                      vector:^LKOperation *(LKVector *first) {
                          return [self operation:^(LKVector *destination, LKUInteger length) {
                              LK_vDSP(vmsb)(LKUnwrap(self), LKUnwrap(first), LKUnwrap(second), LKUnwrap(destination), length);
                          }];
                      }];
    }];
}


- (LKOperation *)multipliedBy:(id<LKArithmetic>)first subtractedFrom:(id<LKArithmetic>)second {
    return [self operand:first scalar:^LKOperation *(LKFloat first) {
        return [self multipliedBy:@(-first) addedTo:second]; // (A × −B) + C
    } vector:^LKOperation *(LKVector *first) {
        return [[[self multipliedBy:first] vectorize] subtractedFrom:second];
    }];
}



@end


