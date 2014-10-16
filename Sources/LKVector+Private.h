//
//  LKVector+Private.h
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"



@interface LKVector ()

- (instancetype)initSubclass;

@end



#define VKUnwrap(LKVector)      (self.values), (self.stride)


