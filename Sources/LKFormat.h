//
//  LKFormat.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"



@interface LKFormat : NSObject


+ (instancetype)formatWithType:(const char *)encodedType normalized:(BOOL)normalized;

- (instancetype)initWithType:(const char *)encodedType normalization:(LKFloat)factor;
@property (readonly) const char *type;
@property (readonly) LKFloat normalizationFactor;


@end


