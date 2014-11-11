//
//  LKVector+Summing.h
//  LinearKit
//
//  Created by Martin Kiss on 11.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Summing)


#pragma mark Sums

- (LKFloat)sum;
- (LKFloat)magnitudesSum;
- (LKFloat)squaresSum;
- (LKFloat)signedSquaresSum;

- (LKOperation *)slidingWindowSum:(LKInteger)window;


#pragma mark Integration

- (LKOperation *)runningSumIntegration:(LKFloat)weight;
- (LKOperation *)simpsonIntegration:(LKFloat)step;
- (LKOperation *)trapezoidalIntegration:(LKFloat)step;


@end


