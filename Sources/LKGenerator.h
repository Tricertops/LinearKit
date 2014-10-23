//
//  LKGenerator.h
//  LinearKit
//
//  Created by Martin Kiss on 23.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKVector.h"



@interface LKGenerator : NSObject <LKSource>


#pragma mark - Creating

+ (instancetype)generatorWithBlock:(LKGeneratorBlock)block;
+ (instancetype)generatorWithIndexBlock:(LKGeneratorIndexBlock)block;
- (instancetype)initWithBlock:(LKGeneratorBlock)block;


#pragma mark - Using

- (LKVector *)vectorizeWithLength:(LKInteger)length;
- (void)fillVector:(LKVector *)vector;


@end


