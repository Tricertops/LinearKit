//
//  VKVector+Private.h
//  VectorKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKVector.h"



@interface VKVector ()

- (instancetype)initSubclass;

@end



#define VKUnwrap(VKVector)      (self.values), (self.stride)


