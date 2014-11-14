//
//  LKVector+Arithmetics.h
//  LinearKit
//
//  Created by Martin Kiss on 13.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Arithmetics) <LKArithmetic>



#pragma mark Multiply

- (LKOperation *)multipliedByRampFrom:(LKFloat)first by:(LKFloat)step;


#pragma mark Squares

- (LKOperation *)squared;
- (LKOperation *)signedSquared;



@end


