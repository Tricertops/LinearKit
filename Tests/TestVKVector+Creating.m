//
//  TestVKVector+Creating.m
//  VectorKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import XCTest;
#import "VectorKit.h"



@interface TestVKVector_Creating : XCTestCase

@end





@implementation TestVKVector_Creating



- (void)test_VKVectorMake {
    VKVector *vector = VKVectorMake(1, 4, 6, 7, 1);
    XCTAssertNotNil(vector);
    XCTAssertEqual(vector.length, 5);
    XCTAssertEqual(vector.values[0], 1);
    XCTAssertEqual(vector.values[1], 4);
    XCTAssertEqual(vector.values[2], 6);
    XCTAssertEqual(vector.values[3], 7);
    XCTAssertEqual(vector.values[4], 1);
}


- (void)test_VKVectorMake_noValues {
    VKVector *vector = VKVectorMake();
    XCTAssertNotNil(vector);
    XCTAssertEqual(vector.values, NULL);
    XCTAssertEqual(vector.stride, 1);
    XCTAssertEqual(vector.length, 0);
}



- (void)test_vectorWithLength {
    VKVector *vector = [VKVector vectorWithLength:5];
    XCTAssertNotEqual(vector.values, NULL);
    XCTAssertEqual(vector.stride, 1);
    XCTAssertEqual(vector.length, 5);
    XCTAssertEqual(vector.values[0], 0);
    XCTAssertEqual(vector.values[1], 0);
    XCTAssertEqual(vector.values[2], 0);
    XCTAssertEqual(vector.values[3], 0);
    XCTAssertEqual(vector.values[4], 0);
}


- (void)test_vectorWithLength_zero {
    VKVector *vector = [VKVector vectorWithLength:0];
    XCTAssertNotNil(vector);
    XCTAssertEqual(vector.values, NULL);
    XCTAssertEqual(vector.stride, 1);
    XCTAssertEqual(vector.length, 0);
}



@end
