//
//  LKVector.h
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKFormat.h"



@interface LKVector : NSObject <LKSource>


#pragma mark Creating

+ (LKVector *)vectorWithLength:(LKInteger)length;
+ (LKVector *)vectorFromData:(NSData *)data format:(LKFormat *)format;
#define LKVectorMake(LKFloat...)    _LKVectorMake(LKFloat)

- (LKVector *)initWithMutableData:(NSMutableData *)data;
+ (LKVector *)new NS_UNAVAILABLE;
- (LKVector *)init NS_UNAVAILABLE;


#pragma mark Duplication

- (LKVector *)copy;
- (void)set:(id<LKSource>)source;


#pragma mark Accessing

@property (readonly) LKInteger length;
- (LKFloat)valueAtIndex:(LKInteger)index;
- (void)setValue:(LKFloat)value atIndex:(LKInteger)index;

- (LKFloat*)referenceAtIndex:(LKInteger)index;
- (LKFloat*(^)(LKInteger index))at;
- (void)enumerateConcurrently:(BOOL)concurrently block:(void(^)(LKInteger index, LKFloat* reference))block;


#pragma mark Export

- (NSMutableData *)copyDataWithFormat:(LKFormat *)format;


#pragma mark Comparison

- (NSUInteger)hash;
- (BOOL)isEqual:(LKVector *)other;
- (BOOL)isEqual:(LKVector *)other epsilon:(LKFloat)epsilon;


@end



#pragma mark -

#define _LKVectorMake(...) \
(LKVector *)({ \
    LKFloat values[] = { __VA_ARGS__ }; \
    NSMutableData *data = [NSMutableData dataWithBytes:values length:sizeof(values)]; \
    [[LKVector alloc] initWithMutableData:data]; \
})


