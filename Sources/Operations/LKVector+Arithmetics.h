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



#pragma mark Addition & Subtraction

- (LKOperation *)negated;       // −A
- (LKOperation *)addedTo:(id<LKArithmetic>)other;           // A + B
- (LKOperation *)subtracted:(id<LKArithmetic>)other;        // A − B
- (LKOperation *)subtractedFrom:(id<LKArithmetic>)other;    // B − A


#pragma mark Multiplication & Division

- (LKOperation *)inverted;      // 1 ÷ A
- (LKOperation *)multipliedBy:(id<LKArithmetic>)other;      // A × B
- (LKOperation *)dividedBy:(id<LKArithmetic>)other;         // A ÷ B
- (LKOperation *)dividing:(id<LKArithmetic>)other;          // B ÷ A
- (LKOperation *)squared;       // A²
- (LKOperation *)signedSquared; // A × |A|

- (LKOperation *)multipliedByRampFrom:(LKFloat)first by:(LKFloat)step;


#pragma mark Combined

- (LKOperation *)addedTo:(id<LKArithmetic>)first multipliedBy:(id<LKArithmetic>)second;         // (A + B) × C
- (LKOperation *)subtracted:(id<LKArithmetic>)first multipliedBy:(id<LKArithmetic>)second;      // (A − B) × C
- (LKOperation *)subtractedFrom:(id<LKArithmetic>)first multipliedBy:(id<LKArithmetic>)second;  // (B − A) × C

- (LKOperation *)multipliedBy:(id<LKArithmetic>)first addedTo:(id<LKArithmetic>)second;         // (A × B) + C
- (LKOperation *)multipliedBy:(id<LKArithmetic>)first subtracted:(id<LKArithmetic>)second;      // (A × B) − C
- (LKOperation *)multipliedBy:(id<LKArithmetic>)first subtractedFrom:(id<LKArithmetic>)second;  // C − (A × B)



@end


