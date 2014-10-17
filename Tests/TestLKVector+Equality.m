//
//  TestLKVector+Equality.m
//  LinearKit
//
//  Created by Martin Kiss on 17.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import XCTest;
#import "LinearKit.h"
#import "LKVector+Private.h"



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
    [b setValue:5 atIndex:0];
    XCTAssertNotEqualObjects(a, b);
    XCTAssertNotEqual(a.hash, b.hash);
}



@end


