//
//  LKSubvector.m
//  LinearKit
//
//  Created by Martin Kiss on 18.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKSubvector.h"
#import "LKPrivate.h"



@interface LKSubvector ()

@property (readonly) LKVector *source;
@property (readonly) LKInteger offset;

@property (readonly) LKFloat* head;
@property (readonly) LKInteger stride;
@property (readonly) LKInteger length;

- (instancetype)initWithSource:(LKVector *)vector offset:(LKInteger)offset stride:(LKInteger)stride length:(LKInteger)length;

@end





@implementation LKSubvector



@synthesize head = _head;
@synthesize stride = _stride;
@synthesize length = _length;



- (instancetype)initWithSource:(LKVector *)vector offset:(LKInteger)offset stride:(LKInteger)stride length:(LKInteger)length {
    self = [super initSubclass];
    if (self) {
        self->_source = vector;
        self->_offset = offset;
        [vector validateIndex:offset];
        
        self->_head = [vector referenceAtIndex:offset];
        self->_stride = vector.stride * stride;
        self->_length = length;
        
        [self validateIndex:(length - 1)];
    }
    return self;
}


- (LKInteger)indexToSource:(LKInteger)index {
    LKInteger stride = self->_stride / self->_source.stride;
    return self->_offset + index * stride;
}


- (LKInteger)indexFromSouce:(LKInteger)sourceIndex {
    LKInteger stride = self->_stride / self->_source.stride;
    LKInteger delta = sourceIndex - self->_offset;
    if (delta % stride) {
        @throw LKException(LKIndexException, @"Cannot convert index from source vector.");
    }
    return delta / stride;
}


- (BOOL)isIndexValid:(LKInteger)index {
    if ( ! [super isIndexValid:index]) return NO;
    LKInteger sourceIndex = [self indexToSource:index];
    return [self->_source isIndexValid:sourceIndex];
}



- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p; offset=%li; stride=%li; length=%li; source=%@>", self.class, self, self->_offset, self->_stride, self->_length, self->_source.debugDescription];
}



@end





@implementation LKVector (Subvector)



- (LKVector *)subvectorFrom:(LKInteger)start {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:1 length:self.length - start];
}


- (LKVector *)subvectorTo:(LKInteger)end {
    return [[LKSubvector alloc] initWithSource:self offset:0 stride:1 length:(end + 1)];
}


- (LKVector *)subvectorWithLength:(LKInteger)length {
    return [[LKSubvector alloc] initWithSource:self offset:0 stride:1 length:length];
}


- (LKVector *)subvectorBy:(LKInteger)stride {
    return [[LKSubvector alloc] initWithSource:self offset:0 stride:stride length:ceil((LKFloat)self.length / stride)];
}


- (LKVector *)subvectorFrom:(LKInteger)start to:(LKInteger)end {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:1 length:(end + 1) - start];
}


- (LKVector *)subvectorFrom:(LKInteger)start length:(LKInteger)length {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:1 length:length];
}


- (LKVector *)subvectorFrom:(LKInteger)start by:(LKInteger)stride {
    return [[LKSubvector alloc] initWithSource:self offset:start stride:stride length:ceil((LKFloat)(self.length-start) / stride)];
}


- (LKVector *)reversed {
    return [[LKSubvector alloc] initWithSource:self offset:(self.length - 1) stride:-1 length:self.length];
}



@end


