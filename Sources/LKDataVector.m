//
//  LKDataVector.m
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKDataVector.h"
#import "LKVector+Private.h"



@interface LKDataVector ()

@property (readonly) NSMutableData *data;

@property (readonly) LKFloat* head;
@property (readonly) LKInteger length;

@end





@implementation LKDataVector



@synthesize head = _head;
@synthesize length = _length;



- (LKVector *)initWithMutableData:(NSMutableData *)data {
    self = [super initSubclass];
    if (self) {
        self->_data = (data.length? data : nil);
        self->_head = self->_data.mutableBytes;
        self->_length = LKSigned(data.length / sizeof(LKFloat));
    }
    return self;
}


- (LKInteger)stride {
    return 1;
}



- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p; length=%li; data=<%@:%p>>", self.class, self, self->_length, self->_data.class, self->_data];
}



@end


