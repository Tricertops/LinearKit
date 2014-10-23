//
//  LKVector+Generating.h
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Generating)


- (void)clear;
- (void)fill:(LKFloat)constant;
- (void)rampFrom:(LKFloat)first by:(LKFloat)step;
- (void)interpolateFrom:(LKFloat)first to:(LKFloat)last;


@end



#pragma mark -

@interface LKOperation (Generators)


+ (LKOperation *)clear;
+ (LKOperation *)fill:(LKFloat)constant;
+ (LKOperation *)rampFrom:(LKFloat)first by:(LKFloat)step;
+ (LKOperation *)interpolateFrom:(LKFloat)first to:(LKFloat)last;


@end


