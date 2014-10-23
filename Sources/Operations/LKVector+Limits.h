//
//  LKVector+Limits.h
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"





@interface LKVector (Limits)


#pragma mark Clipping

- (LKOperation *)clippedBelow:(LKFloat)lowest;
- (LKOperation *)clippedAbove:(LKFloat)highest;
- (LKOperation *)clippedBelow:(LKFloat)lowest above:(LKFloat)highest;

- (void)clipTo:(LKVector *)destination below:(LKFloat)lowest count:(out LKInteger *)below above:(LKFloat)highest count:(out LKInteger *)above;

- (LKOperation *)invertClippedAbove:(LKFloat)lowest below:(LKFloat)highest;

- (LKOperation *)clearedBelow:(LKFloat)lowest;


#pragma mark Comparison

- (LKOperation *)comparedTo:(LKFloat)limit;
- (LKOperation *)comparedTo:(LKFloat)limit mark:(LKFloat)value;



@end


