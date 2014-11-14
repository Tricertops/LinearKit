//
//  LKPrivate.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKVector.h"
#import "LKSubvector.h"
#import "LKOperation.h"



@interface LKVector ()

@property (readonly) LKFloat* head;
@property (readonly) LKInteger stride;

- (instancetype)initSubclass;

- (BOOL)isIndexValid:(LKInteger)index;
- (void)validateIndex:(LKInteger)index;

- (BOOL)isReverseOf:(LKVector *)vector;

- (LKVector *)linearized;

- (LKOperation *)operation:(LKOperationBlock)block;

@end



@interface LKSubvector ()

@end



@interface LKOperation ()

+ (LKOperation *)wrap:(LKVector *)vector;

@end



#pragma mark - Exceptions

extern NSString * const LKIndexException;
extern NSString * const LKLengthException;
extern NSString * const LKFormatException;
extern NSString * const LKArithmeticException;
extern NSException * LKException(NSString *name, NSString *format, ...) NS_FORMAT_FUNCTION(2, 3);



#pragma mark - Invocation

#define LKUnwrap(LKVector)      (LKVector.head), (LKVector.stride)

#define LK_vDSP(name)           LKPrecision(vDSP_ ## name, vDSP_ ## name ## D)
#define LK_f(name)              LKPrecision(name ## f, name)


