//
//  TestLKVector+Creating.m
//  LinearKit
//
//  Created by Martin Kiss on 16.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import XCTest;
#import "LinearKit.h"



@interface TestLKVector_Creating : XCTestCase

@end





@implementation TestLKVector_Creating



- (void)test_LKVectorMake {
    LKVector *vector = LKVectorMake(1, 4, 6, 7, 1);
    XCTAssertNotNil(vector);
    XCTAssertEqual(vector.length, 5);
    XCTAssertEqual(vector.values[0], 1);
    XCTAssertEqual(vector.values[1], 4);
    XCTAssertEqual(vector.values[2], 6);
    XCTAssertEqual(vector.values[3], 7);
    XCTAssertEqual(vector.values[4], 1);
}


- (void)test_LKVectorMake_noValues {
    LKVector *vector = LKVectorMake();
    XCTAssertNotNil(vector);
    XCTAssertEqual(vector.values, NULL);
    XCTAssertEqual(vector.stride, 1);
    XCTAssertEqual(vector.length, 0);
}



- (void)test_vectorWithLength {
    LKVector *vector = [LKVector vectorWithLength:5];
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
    LKVector *vector = [LKVector vectorWithLength:0];
    XCTAssertNotNil(vector);
    XCTAssertEqual(vector.values, NULL);
    XCTAssertEqual(vector.stride, 1);
    XCTAssertEqual(vector.length, 0);
}



@end
