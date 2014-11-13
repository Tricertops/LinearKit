//
//  LKSubvector.h
//  LinearKit
//
//  Created by Martin Kiss on 22.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKTypes.h"
#import "LKVector.h"



@interface LKSubvector : LKVector

@end



#pragma mark -

@interface LKVector (Subvector)


#pragma mark Subrange

- (LKSubvector *)subvectorFrom:(LKInteger)start;
- (LKSubvector *)subvectorTo:(LKInteger)end;
- (LKSubvector *)subvectorWithLength:(LKInteger)length;
- (LKSubvector *)subvectorFrom:(LKInteger)start to:(LKInteger)end;
- (LKSubvector *)subvectorFrom:(LKInteger)start length:(LKInteger)length;

#pragma mark Substride

- (LKSubvector *)subvectorBy:(LKInteger)stride;
- (LKSubvector *)subvectorFrom:(LKInteger)start by:(LKInteger)stride;

#pragma mark Reversing

- (LKSubvector *)reversed;


#pragma mark Components

- (LKSubvector *)component:(LKInteger)index of:(LKInteger)count;
- (NSArray *)unzipped:(LKInteger)count;


@end


