//
//  LKVector+Averages.m
//  LinearKit
//
//  Created by Martin Kiss on 11.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Averages.h"
#import "LKPrivate.h"



@implementation LKVector (Averages)



#pragma mark Averaging


- (void)averageInclude:(LKVector *)other weight:(LKFloat)weight {
    LK_vDSP(vavlin)(LKUnwrap(other), &weight, LKUnwrap(self), LKUnsigned(self.length));
}


- (LKOperation *)averageWith:(LKVector *)other {
    return [LKOperation averageOf:@[ self, other ]];
}



#pragma mark Means


- (LKFloat)mean {
    LKFloat mean = LKNAN;
    LK_vDSP(meanv)(LKUnwrap(self), &mean, LKUnsigned(self.length));
    return mean;
}


- (LKFloat)magnitudeMean {
    LKFloat magnitudeMean = LKNAN;
    LK_vDSP(meamgv)(LKUnwrap(self), &magnitudeMean, LKUnsigned(self.length));
    return magnitudeMean;
}


- (LKFloat)squareMean {
    LKFloat squareMean = LKNAN;
    LK_vDSP(measqv)(LKUnwrap(self), &squareMean, LKUnsigned(self.length));
    return squareMean;
}


- (LKFloat)signedSquareMean {
    LKFloat signedSquareMean = LKNAN;
    LK_vDSP(mvessq)(LKUnwrap(self), &signedSquareMean, LKUnsigned(self.length));
    return signedSquareMean;
}


- (LKFloat)rootMeanSquare {
    LKFloat rootMeanSquare = LKNAN;
    LK_vDSP(rmsqv)(LKUnwrap(self), &rootMeanSquare, LKUnsigned(self.length));
    return rootMeanSquare;
}



@end



@implementation LKOperation (Miscellaneous)


+ (LKOperation *)averageOf:(NSArray *)vectors {
    //TODO: Check lengths frequently.
    LKVector *firstVector = vectors.firstObject;
    
    return [LKOperation operationWithLength:firstVector.length block:^(LKVector *destination, __unused LKUInteger length) {
        [vectors enumerateObjectsUsingBlock:^(LKVector *vector, NSUInteger index, __unused BOOL *stop) {
            if (index == 0) {
                [destination set:vector];
            }
            else {
                [destination averageInclude:vector weight:index];
            }
        }];
    }];
}


@end


