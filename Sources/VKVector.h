//
//  VKVector.h
//  VectorKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "VKTypes.h"





@interface VKVector : NSObject

@property (readonly) VKFloat* values;
@property (readonly) VKStride stride;
@property (readonly) VKLength length;

@end





@interface VKVector (Creating) <NSCopying>

+ (VKVector *)vectorWithLength:(VKLength)length;
- (VKVector *)copy;

#define VKVectorMake(VKFloat...)    _VKVectorMake(VKFloat)
- (VKVector *)initWithValues:(const VKFloat[])values length:(VKLength)length;

+ (VKVector *)new NS_UNAVAILABLE;
- (VKVector *)init NS_UNAVAILABLE;

@end





@interface VKVector (Equality)

- (NSUInteger)hash;
- (BOOL)isEqual:(VKVector *)other;

@end





@interface VKVector (Filling)

- (void)clear;
- (void)fill:(VKFloat)value;
- (void)generateFrom:(VKFloat)start by:(VKFloat)step;
- (void)generateFrom:(VKFloat)start to:(VKFloat)end;

- (void)setValues:(VKVector *)vector;

@end





@interface VKVector (Subvector)

- (VKVector *)from:(VKOffset)start;
- (VKVector *)to:(VKOffset)end;
- (VKVector *)by:(VKStride)stride;

- (VKVector *)from:(VKOffset)start to:(VKOffset)end;
- (VKVector *)from:(VKOffset)start length:(VKLength)length;
- (VKVector *)from:(VKOffset)start by:(VKStride)stride;

@end










#define _VKVectorMake(...) \
(VKVector *)({ \
    VKFloat values[] = { __VA_ARGS__ }; \
    [[VKVector alloc] initWithValues:values length:sizeof(values)/sizeof(VKFloat)]; \
})


