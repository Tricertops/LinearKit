//
//  TestLKVector+Subvector.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import XCTest;
#import "LinearKit.h"
#import "LKVector+Private.h"



@interface TestLKVector_Subvector : XCTestCase

@end



@implementation TestLKVector_Subvector



#define TestLKVector    LKVectorMake(4, 7.9, 0.834513759, -486.47, M_PI)


- (void)test_subvectorFrom {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorFrom:0], vector);
    XCTAssertEqualObjects([vector subvectorFrom:1], LKVectorMake(7.9, 0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:2], LKVectorMake(0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:3], LKVectorMake(-486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:4], LKVectorMake(M_PI));
}


- (void)test_subvectorTo {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorTo:0], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorTo:1], LKVectorMake(4, 7.9));
    XCTAssertEqualObjects([vector subvectorTo:2], LKVectorMake(4, 7.9, 0.834513759));
    XCTAssertEqualObjects([vector subvectorTo:3], LKVectorMake(4, 7.9, 0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorTo:4], vector);
}


- (void)test_subvectorWithLength {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorWithLength:1], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorWithLength:2], LKVectorMake(4, 7.9));
    XCTAssertEqualObjects([vector subvectorWithLength:3], LKVectorMake(4, 7.9, 0.834513759));
    XCTAssertEqualObjects([vector subvectorWithLength:4], LKVectorMake(4, 7.9, 0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorWithLength:5], vector);
}


- (void)test_subvectorBy {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorBy:1], vector);
    XCTAssertEqualObjects([vector subvectorBy:2], LKVectorMake(4, 0.834513759, M_PI));
    XCTAssertEqualObjects([vector subvectorBy:3], LKVectorMake(4, -486.47));
    XCTAssertEqualObjects([vector subvectorBy:4], LKVectorMake(4, M_PI));
    XCTAssertEqualObjects([vector subvectorBy:5], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorBy:6], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorBy:6724576254], LKVectorMake(4));
}


- (void)test_subvectorFromTo {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorFrom:0 to:0], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorFrom:0 to:1], LKVectorMake(4, 7.9));
    XCTAssertEqualObjects([vector subvectorFrom:0 to:2], LKVectorMake(4, 7.9, 0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:0 to:3], LKVectorMake(4, 7.9, 0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:0 to:4], vector);
    XCTAssertEqualObjects([vector subvectorFrom:1 to:1], LKVectorMake(7.9));
    XCTAssertEqualObjects([vector subvectorFrom:1 to:2], LKVectorMake(7.9, 0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:1 to:3], LKVectorMake(7.9, 0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:1 to:4], LKVectorMake(7.9, 0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:2 to:2], LKVectorMake(0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:2 to:3], LKVectorMake(0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:2 to:4], LKVectorMake(0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:3 to:3], LKVectorMake(-486.47));
    XCTAssertEqualObjects([vector subvectorFrom:3 to:4], LKVectorMake(-486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:4 to:4], LKVectorMake(M_PI));
}


- (void)test_subvectorFromLength {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorFrom:0 length:1], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorFrom:0 length:2], LKVectorMake(4, 7.9));
    XCTAssertEqualObjects([vector subvectorFrom:0 length:3], LKVectorMake(4, 7.9, 0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:0 length:4], LKVectorMake(4, 7.9, 0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:0 length:5], vector);
    XCTAssertEqualObjects([vector subvectorFrom:1 length:1], LKVectorMake(7.9));
    XCTAssertEqualObjects([vector subvectorFrom:1 length:2], LKVectorMake(7.9, 0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:1 length:3], LKVectorMake(7.9, 0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:1 length:4], LKVectorMake(7.9, 0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:2 length:1], LKVectorMake(0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:2 length:2], LKVectorMake(0.834513759, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:2 length:3], LKVectorMake(0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:3 length:1], LKVectorMake(-486.47));
    XCTAssertEqualObjects([vector subvectorFrom:3 length:2], LKVectorMake(-486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:4 length:1], LKVectorMake(M_PI));
}


- (void)test_subvectorFromBy {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector subvectorFrom:0 by:1], vector);
    XCTAssertEqualObjects([vector subvectorFrom:0 by:2], LKVectorMake(4, 0.834513759, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:0 by:3], LKVectorMake(4, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:0 by:4], LKVectorMake(4, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:0 by:5], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorFrom:0 by:6], LKVectorMake(4));
    XCTAssertEqualObjects([vector subvectorFrom:1 by:1], LKVectorMake(7.9, 0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:1 by:2], LKVectorMake(7.9, -486.47));
    XCTAssertEqualObjects([vector subvectorFrom:1 by:3], LKVectorMake(7.9, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:1 by:4], LKVectorMake(7.9));
    XCTAssertEqualObjects([vector subvectorFrom:1 by:5], LKVectorMake(7.9));
    XCTAssertEqualObjects([vector subvectorFrom:2 by:1], LKVectorMake(0.834513759, -486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:2 by:2], LKVectorMake(0.834513759, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:2 by:3], LKVectorMake(0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:2 by:4], LKVectorMake(0.834513759));
    XCTAssertEqualObjects([vector subvectorFrom:3 by:1], LKVectorMake(-486.47, M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:3 by:2], LKVectorMake(-486.47));
    XCTAssertEqualObjects([vector subvectorFrom:3 by:3], LKVectorMake(-486.47));
    XCTAssertEqualObjects([vector subvectorFrom:4 by:1], LKVectorMake(M_PI));
    XCTAssertEqualObjects([vector subvectorFrom:4 by:2], LKVectorMake(M_PI));
}


- (void)test_reversed {
    LKVector *vector = TestLKVector;
    XCTAssertEqualObjects([vector reversed], LKVectorMake(M_PI, -486.47, 0.834513759, 7.9, 4));
    XCTAssertEqualObjects([[vector reversed] reversed], vector);
    XCTAssertEqualObjects([[vector subvectorWithLength:3] reversed], LKVectorMake(0.834513759, 7.9, 4));
    XCTAssertEqualObjects([[vector subvectorBy:2] reversed], LKVectorMake(M_PI, 0.834513759, 4));
    XCTAssertEqualObjects([[vector subvectorFrom:3 to:4] reversed], LKVectorMake(M_PI, -486.47));
}



@end


