//
//  LKVector.h
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"





@interface LKVector : NSObject

@end





@interface LKVector (Creating) <NSCopying>

+ (LKVector *)vectorWithLength:(LKInteger)length;
- (LKVector *)copy;

#define LKVectorMake(LKFloat...)    _LKVectorMake(LKFloat)
- (LKVector *)initWithMutableData:(NSMutableData *)data;

+ (LKVector *)new NS_UNAVAILABLE;
- (LKVector *)init NS_UNAVAILABLE;

@end





@interface LKVector (Accessing)

@property (readonly) LKInteger length;
- (LKFloat)valueAtIndex:(LKInteger)index;
- (void)setValue:(LKFloat)value atIndex:(LKInteger)index;

- (LKFloat*(^)(LKInteger index))at;
- (void)enumerateConcurrently:(BOOL)concurrently block:(void(^)(LKInteger index, LKFloat* reference))block;

@end





@interface LKVector (Equality)

- (NSUInteger)hash;
- (BOOL)isEqual:(LKVector *)other;
- (BOOL)isEqual:(LKVector *)other epsilon:(LKFloat)epsilon;

@end





@interface LKVector (Filling)

- (void)clear;
- (void)fill:(LKFloat)value;
- (void)generateFrom:(LKFloat)start by:(LKFloat)step;
- (void)generateFrom:(LKFloat)start to:(LKFloat)end;

- (void)setValues:(LKVector *)vector;

@end





@interface LKVector (Subvector)

- (LKVector *)subvectorFrom:(LKInteger)start;
- (LKVector *)subvectorTo:(LKInteger)end;
- (LKVector *)subvectorBy:(LKInteger)stride;

- (LKVector *)subvectorFrom:(LKInteger)start to:(LKInteger)end;
- (LKVector *)subvectorFrom:(LKInteger)start length:(LKInteger)length;
- (LKVector *)subvectorFrom:(LKInteger)start by:(LKInteger)stride;

- (LKVector *)reversedVector; //TODO: Negative stride.

@end










#define _LKVectorMake(...) \
(LKVector *)({ \
    LKFloat values[] = { __VA_ARGS__ }; \
    NSMutableData *data = [NSMutableData dataWithBytes:values length:sizeof(values)]; \
    [[LKVector alloc] initWithMutableData:data]; \
})


