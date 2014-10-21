//
//  LKVector+Description.m
//  LinearKit
//
//  Created by Martin Kiss on 18.10.14.
//  Copyright (c) 2014 Triceratops. All rights reserved.
//

#import "LKVector.h"





@implementation LKVector (Description)



- (NSString *)description {
    // [a, b, c, d, ... 20 more ]
    LKInteger printedLength = MIN(self.length, 20);
    
    NSMutableArray *values = [NSMutableArray new];
    for (LKInteger index = 0; index < printedLength; index++) {
        LKFloat value = [self valueAtIndex:index];
        [values addObject:[NSString stringWithFormat:@"%f", value]];
    }
    
    NSMutableString *description = [NSMutableString new];
    [description appendString:@"["];
    [description appendString:[values componentsJoinedByString:@", "]];
    LKInteger more = self.length - printedLength;
    if (more > 0) {
        [description appendFormat:@", ... %li more", more];
    }
    [description appendString:@"]"];
    return description;
}



@end


