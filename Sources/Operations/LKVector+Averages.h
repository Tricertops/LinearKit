//
//  LKVector+Averages.h
//  LinearKit
//
//  Created by Martin Kiss on 11.11.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"
#import "LKOperation.h"



@interface LKVector (Averages)


#pragma mark - Averaging

- (LKOperation *)averageWith:(LKVector *)other;
- (void)averageInclude:(LKVector *)other weight:(LKFloat)weight;



@end



@interface LKOperation (Miscellaneous)


+ (LKOperation *)averageOf:(NSArray *)vectors;


@end


