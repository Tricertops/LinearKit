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


