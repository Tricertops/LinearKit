//
//  LKVector+Signs.h
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"





@interface LKVector (Signs)


- (LKOperation *)absolute;
- (LKOperation *)negativeAbsolute;

- (LKOperation *)signs;


@end


