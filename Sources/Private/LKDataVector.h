//
//  LKDataVector.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKVector.h"



@interface LKDataVector : LKVector

- (LKVector *)initWithMutableData:(NSMutableData *)data;

@end


