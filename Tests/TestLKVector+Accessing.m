//
//  TestLKVector+Accessing.m
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

@import XCTest;
#import "LinearKit.h"
#import "LKVector+Private.h"



@interface TestLKVector_Accessing : XCTestCase

@end



static LKFloat TestLKHash(LKFloat value) {
    for (LKInteger i = 0; i < 1000; i++) {
        value = LKHash(value);
    }
    return value;
}



@implementation TestLKVector_Accessing



#define TestLKVectorLength  10000


- (void)test_enumerationSerial_measure {
    LKVector *vector = [LKVector vectorWithLength:TestLKVectorLength];
    
    [self measureBlock:^{
        [vector enumerateConcurrently:NO block:^(LKInteger index, LKFloat *reference) {
            *reference = TestLKHash(index);
        }];
    }];
    
    XCTAssertEqual(*vector.at(42), TestLKHash(42));
    XCTAssertEqual(*vector.at(vector.length/2), TestLKHash(vector.length/2));
    XCTAssertEqual(*vector.at(vector.length-1), TestLKHash(vector.length-1));
}


- (void)test_enumerationConcurrent_measure {
    LKVector *vector = [LKVector vectorWithLength:TestLKVectorLength];
    
    [self measureBlock:^{
        [vector enumerateConcurrently:YES block:^(LKInteger index, LKFloat *reference) {
            *reference = TestLKHash(index);
        }];
    }];
    
    XCTAssertEqual(*vector.at(1), TestLKHash(1));
    XCTAssertEqual(*vector.at(vector.length/2), TestLKHash(vector.length/2));
    XCTAssertEqual(*vector.at(vector.length-1), TestLKHash(vector.length-1));
}



@end


