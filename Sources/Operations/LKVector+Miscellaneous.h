//
//  LKVector+Miscellaneous.h
//  LinearKit
//
//  Created by Martin Kiss on 27.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Miscellaneous)


- (LKOperation *)fractions;
//TODO: round, ceil, floor


- (LKOperation *)selected:(LKVector *)indexes;
- (LKOperation *)selected:(LKVector *)indexes interpolate:(BOOL)interpolate;

- (LKOperation *)compressed;
- (LKOperation *)compressedWithGate:(LKVector *)gate;

- (LKInteger)findNumberOfZeroCrossings;
- (LKInteger)indexOfZeroCrossing:(LKInteger)crossing;
- (LKInteger)findZeroCrossingsWithMaxCount:(LKInteger)max lastIndex:(out LKInteger *)last;

- (void)sortAscending:(BOOL)ascending;
- (void)swapWith:(LKVector *)other;

- (LKOperation *)correlatedWithFilter:(LKVector *)filter;
- (LKOperation *)convolutedWithFilter:(LKVector *)filter;


- (LKOperation *)zippedWith:(LKVector *)other;


@end



@interface LKOperation (Miscellaneous)


+ (LKOperation *)zipped:(NSArray *)vectors;


@end


