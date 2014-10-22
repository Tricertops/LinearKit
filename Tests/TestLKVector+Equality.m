//
//  TestLKVector+Equality.m
//  LinearKit
//
//  Created by Martin Kiss on 17.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import XCTest;
#import "LinearKit.h"
#import "LKPrivate.h"



@interface TestLKVector_Equality : XCTestCase

@end



@implementation TestLKVector_Equality



#define TestLKVector    LKVectorMake(4, 7.9, 0.834513759, -486.47, M_PI)


- (void)test_equal {
    LKVector *a = TestLKVector;
    LKVector *b = TestLKVector;
    XCTAssertEqualObjects(a, b);
    XCTAssertEqual(a.hash, b.hash);
}


- (void)test_inequal {
    LKVector *a = TestLKVector;
    LKVector *b = TestLKVector;
    *b.at(0) += 1;
    XCTAssertNotEqualObjects(a, b);
    XCTAssertNotEqual(a.hash, b.hash);
}


- (void)test_epsilon {
    LKVector *a = TestLKVector;
    LKVector *b = TestLKVector;
    *b.at(2) += LKEpsion;
    XCTAssertNotEqualObjects(a, b);
    XCTAssertNotEqual(a.hash, b.hash);
    XCTAssertTrue([a isEqual:b epsilon:LKEpsion]);
}


- (void)test_copy {
    LKVector *a = TestLKVector;
    LKVector *b = [a copy];
    XCTAssertNotEqual(a, b);
    XCTAssertEqualObjects(a, b);
}



@end


