//
//  LKPrivate.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKVector.h"



@interface LKVector ()

@property (readonly) LKFloat* head;
@property (readonly) LKInteger stride;

- (instancetype)initSubclass;

- (BOOL)isIndexValid:(LKInteger)index;
- (void)validateIndex:(LKInteger)index;

- (void)copyValuesTo:(LKVector *)vector;

@end



extern NSString * const LKIndexException;
extern NSString * const LKFormatException;
extern NSException * LKException(NSString *name, NSString *format, ...) NS_FORMAT_FUNCTION(2, 3);



#define LKUnwrap(LKVector)      (LKVector.head), (LKVector.stride)

#define LK_vDSP(name)           LKPrecision(vDSP_ ## name, vDSP_ ## name ## D)
#define LK_f(name)              LKPrecision(name ## f, name)


