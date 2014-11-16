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



- (void)sortAscending:(BOOL)ascending {
    LKVector *linearized = [self linearized];
    LK_vDSP(vsort)(linearized.head, LKUnsigned(linearized.length), (ascending? 1 : -1));
    [self set:linearized];
}


- (void)swapWith:(LKVector *)other {
    LK_vDSP(vswap)(LKUnwrap(self), LKUnwrap(other), LKUnsigned(self.length));
}



- (LKOperation *)correlatedWithFilter:(LKVector *)filter {
    LKVector *subself = [self subvectorWithLength:self.length - filter.length + 1];
    return [subself operation:^(LKVector *destination, LKUInteger length) {
        LK_vDSP(conv)(LKUnwrap(self), LKUnwrap(filter), LKUnwrap(destination), length, LKUnsigned(filter.length));
    }];
}


- (LKOperation *)convolutedWithFilter:(LKVector *)filter {
    return [self correlatedWithFilter:filter.reversed];
}



- (LKOperation *)zippedWith:(LKVector *)other {
    return [LKOperation zipped:@[ self, other ]];
}



@end





@implementation LKOperation (Miscellaneous)



+ (LKOperation *)zipped:(NSArray *)vectors {
    LKInteger componentLength = [(LKVector *)vectors.firstObject length];
    LKInteger count = LKSigned((unsigned long)vectors.count);
    
    return [LKOperation operationWithLength:(componentLength * count)
                                      block:^(LKVector *destination, __unused LKUInteger length) {
                                          NSArray *unzipped = [destination unzipped:count];
                                          NSUInteger index = 0;
                                          for (LKVector *component in unzipped) {
                                              [component set:vectors[index]];
                                              index ++;
                                          }
                                      }];
}



@end


