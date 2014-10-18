//
//  LKSteadyVector.m
//  LinearKit
//
//  Created by Martin Kiss on 15.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector+Private.h"



@interface LKSteadyVector ()

@property (readonly) NSMutableData *data;

@end





@implementation LKSteadyVector



- (LKVector *)initWithMutableData:(NSMutableData *)data {
    self = [super initSubclass];
    if (self) {
        self->_data = (data.length? data : nil);
    }
    return self;
}



- (LKFloat *)head {
    return (LKFloat*)self.data.mutableBytes; //BENCH: _ivar
}


- (LKLength)length {
    return self.data.length / sizeof(LKFloat); //BENCH: _ivar
}


- (LKStride)stride {
    return 1;
}



@end


