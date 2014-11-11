//
//  LKVector+Averages.h
//  LinearKit
//
//  Created by Martin Kiss on 11.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Averages)


#pragma mark Averaging

- (LKOperation *)averageWith:(LKVector *)other;
- (void)averageInclude:(LKVector *)other weight:(LKFloat)weight;


#pragma mark Means

- (LKFloat)mean;
- (LKFloat)magnitudeMean;
- (LKFloat)squareMean;
- (LKFloat)signedSquareMean;
- (LKFloat)rootMeanSquare;


@end



@interface LKOperation (Miscellaneous)


+ (LKOperation *)averageOf:(NSArray *)vectors;


@end


