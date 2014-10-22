//
//  LKFormat.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
@class LKVector;



@interface LKFormat : NSObject


#define LKFormatMake(type)            ( [LKFormat formatWithType:@encode(type) normalized:NO ] )
#define LKFormatMakeNormalized(type)  ( [LKFormat formatWithType:@encode(type) normalized:YES] )


+ (instancetype)formatWithType:(const char *)encodedType normalized:(BOOL)normalized;

- (instancetype)initWithType:(const char *)encodedType normalization:(LKFloat)factor;
@property (readonly) const char *type;
@property (readonly) LKUInteger typeSize;
@property (readonly) LKFloat normalizationFactor;


- (LKVector *)createVectorFromData:(NSData *)data;
- (NSMutableData *)createDataFromVector:(LKVector *)vector;


@end


