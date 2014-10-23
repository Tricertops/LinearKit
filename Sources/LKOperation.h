//
//  LKOperation.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKVector.h"



@interface LKOperation : NSObject <LKSource>


#pragma mark - Creating

+ (instancetype)operationWithLength:(LKInteger)length block:(LKOperationBlock)block;
- (instancetype)initWithLength:(LKInteger)length block:(LKOperationBlock)block;


#pragma mark - Using

@property (readonly) LKInteger length;
- (LKVector *)vectorize;
- (void)fillVector:(LKVector *)vector;


@end


