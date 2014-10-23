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


#pragma mark Creating

#define LKFormatMake(type)            ( [LKFormat formatWithType:@encode(type) normalized:NO ] )
#define LKFormatMakeNormalized(type)  ( [LKFormat formatWithType:@encode(type) normalized:YES] )

+ (instancetype)formatWithType:(const char *)encodedType normalized:(BOOL)normalized;
- (instancetype)initWithType:(const char *)encodedType normalization:(LKFloat)factor;


#pragma mark Attributes

@property (readonly) const char *type;
@property (readonly) LKUInteger typeSize;
@property (readonly) BOOL isTypeSigned;
@property (readonly) LKFloat normalizationFactor;


#pragma mark Converting

- (LKVector *)createVectorFromData:(NSData *)data;
- (NSMutableData *)createDataFromVector:(LKVector *)vector;


@end


