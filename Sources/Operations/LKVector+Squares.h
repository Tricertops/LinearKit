//
//  LKVector+Squares.h
//  LinearKit
//
//  Created by Martin Kiss on 27.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Squares)


- (LKOperation *)squared;
- (LKOperation *)signedSquared;


@end


