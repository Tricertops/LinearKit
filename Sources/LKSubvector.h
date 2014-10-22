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



@interface LKVector (Subvector)

- (LKSubvector *)subvectorFrom:(LKInteger)start;
- (LKSubvector *)subvectorTo:(LKInteger)end;
- (LKSubvector *)subvectorWithLength:(LKInteger)length;
- (LKSubvector *)subvectorBy:(LKInteger)stride;

- (LKSubvector *)subvectorFrom:(LKInteger)start to:(LKInteger)end;
- (LKSubvector *)subvectorFrom:(LKInteger)start length:(LKInteger)length;
- (LKSubvector *)subvectorFrom:(LKInteger)start by:(LKInteger)stride;

- (LKSubvector *)reversed;

@end


