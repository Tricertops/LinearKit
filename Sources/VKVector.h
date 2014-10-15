//
//  VKVector.h
//  VectorKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKTypes.h"





@interface VKVector : NSObject


@property (readonly) void* underlying;
@property (readonly) VKLength length;
@property (readonly) VKLength offset;
@property (readonly) VKStride stride;


@end


