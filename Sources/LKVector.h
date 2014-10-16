//
//  LKVector.h
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"





@interface LKVector : NSObject

@property (readonly) VKFloat* values;
@property (readonly) VKStride stride;
@property (readonly) VKLength length;

@end





@interface LKVector (Creating) <NSCopying>

+ (LKVector *)vectorWithLength:(VKLength)length;
- (LKVector *)copy;

#define LKVectorMake(VKFloat...)    _LKVectorMake(VKFloat)
- (LKVector *)initWithValues:(const VKFloat[])values length:(VKLength)length;

+ (LKVector *)new NS_UNAVAILABLE;
- (LKVector *)init NS_UNAVAILABLE;

@end





@interface LKVector (Equality)

- (NSUInteger)hash;
- (BOOL)isEqual:(LKVector *)other;

@end





@interface LKVector (Filling)

- (void)clear;
- (void)fill:(VKFloat)value;
- (void)generateFrom:(VKFloat)start by:(VKFloat)step;
- (void)generateFrom:(VKFloat)start to:(VKFloat)end;

- (void)setValues:(LKVector *)vector;

@end





@interface LKVector (Subvector)

- (LKVector *)from:(VKOffset)start;
- (LKVector *)to:(VKOffset)end;
- (LKVector *)by:(VKStride)stride;

- (LKVector *)from:(VKOffset)start to:(VKOffset)end;
- (LKVector *)from:(VKOffset)start length:(VKLength)length;
- (LKVector *)from:(VKOffset)start by:(VKStride)stride;

@end










#define _LKVectorMake(...) \
(LKVector *)({ \
    VKFloat values[] = { __VA_ARGS__ }; \
    [[LKVector alloc] initWithValues:values length:sizeof(values)/sizeof(VKFloat)]; \
})


