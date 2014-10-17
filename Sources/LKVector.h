//
//  LKVector.h
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"





@interface LKVector : NSObject

@property (readonly) LKFloat* values;
@property (readonly) LKStride stride;
@property (readonly) LKLength length;

@end





@interface LKVector (Creating) <NSCopying>

+ (LKVector *)vectorWithLength:(LKLength)length;
- (LKVector *)copy;

#define LKVectorMake(LKFloat...)    _LKVectorMake(LKFloat)
- (LKVector *)initWithValues:(const LKFloat[])values length:(LKLength)length;

+ (LKVector *)new NS_UNAVAILABLE;
- (LKVector *)init NS_UNAVAILABLE;

@end





@interface LKVector (Equality)

- (NSUInteger)hash;
- (BOOL)isEqual:(LKVector *)other;

@end





@interface LKVector (Filling)

- (void)clear;
- (void)fill:(LKFloat)value;
- (void)generateFrom:(LKFloat)start by:(LKFloat)step;
- (void)generateFrom:(LKFloat)start to:(LKFloat)end;

- (void)setValues:(LKVector *)vector;

@end





@interface LKVector (Subvector)

- (LKVector *)from:(LKOffset)start;
- (LKVector *)to:(LKOffset)end;
- (LKVector *)by:(LKStride)stride;

- (LKVector *)from:(LKOffset)start to:(LKOffset)end;
- (LKVector *)from:(LKOffset)start length:(LKLength)length;
- (LKVector *)from:(LKOffset)start by:(LKStride)stride;

@end










#define _LKVectorMake(...) \
(LKVector *)({ \
    LKFloat values[] = { __VA_ARGS__ }; \
    [[LKVector alloc] initWithValues:values length:sizeof(values)/sizeof(LKFloat)]; \
})


