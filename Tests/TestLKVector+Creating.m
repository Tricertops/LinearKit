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





static LKLength const length = 1e8;
static LKLength const size = sizeof(LKFloat);


- (void)test_vectorWithLength_measure {
    LKFloat* ones = calloc(length, size);
    vDSP_vfill(&LKOne, ones, 1, length);
    [self measureBlock:^{
        LKVector *vector = [[LKVector alloc] initWithValues:ones length:length];
        XCTAssertNotNil(vector);
    }];
}


- (void)test_calloc_measure {
    [self measureBlock:^{
        LKFloat* values = calloc(length, size);
        values[0] = INFINITY;
        values[length/2] = values[0];
        values[length-1] = values[length/2];
        XCTAssertEqual(values[0], INFINITY);
        XCTAssertEqual(values[length/2], INFINITY);
        XCTAssertEqual(values[length-1], INFINITY);
        free(values);
    }];
}


- (void)test_mallocFill_measure {
    [self measureBlock:^{
        LKFloat* values = malloc(length * size);
        vDSP_vfill(&LKZero, values, 1, length);
        values[0] = INFINITY;
        values[length/2] = values[0];
        values[length-1] = values[length/2];
        XCTAssertEqual(values[0], INFINITY);
        XCTAssertEqual(values[length/2], INFINITY);
        XCTAssertEqual(values[length-1], INFINITY);
        free(values);
    }];
}


- (void)test_memcpy_measure {
    LKFloat* zeros = calloc(length, size);
    LKFloat* ones = calloc(length, size);
    vDSP_vfill(&LKOne, ones, 1, length);
    [self measureBlock:^{
        memcpy(zeros, ones, length*size);
        XCTAssertEqual(zeros[0], LKOne);
        XCTAssertEqual(zeros[length/2], LKOne);
        XCTAssertEqual(zeros[length-1], LKOne);
    }];
    free(zeros);
    free(ones);
}


- (void)test_matrixMove_measure {
    LKFloat* zeros = calloc(length, size);
    LKFloat* ones = calloc(length, size);
    vDSP_vfill(&LKOne, ones, 1, length);
    [self measureBlock:^{
        vDSP_mmov(ones, zeros, 1, length, 1, 1);
        XCTAssertEqual(zeros[0], LKOne);
        XCTAssertEqual(zeros[length/2], LKOne);
        XCTAssertEqual(zeros[length-1], LKOne);
    }];
    free(zeros);
    free(ones);
}



@end
