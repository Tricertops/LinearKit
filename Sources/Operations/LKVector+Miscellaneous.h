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


- (LKFloat)dotProductWith:(LKVector *)other;


//TODO: vpoly   - solve polynomes of any order
//TODO: vpythg  - distance of coordinates, may need zero-strided vectors
//TODO: venvlp  - preserve values between limits, zero other
//TODO: tmerg   - tapered merge, values transition from first to second vector
//TODO: vquint  - select with quadratic interpolation


@end



@interface LKOperation (Miscellaneous)


+ (LKOperation *)zipped:(NSArray *)vectors;


@end


