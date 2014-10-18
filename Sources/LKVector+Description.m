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
    static LKLength const printedLength = 20;
    NSMutableArray *values = [NSMutableArray new];
    [self enumerateConcurrently:NO block:^(LKIndex index, LKFloat *reference) {
        //TODO: Subvector to count
        if (index < printedLength) {
            [values addObject:[NSString stringWithFormat:@"%g", *reference]];
        }
    }];
    NSMutableString *description = [NSMutableString new];
    [description appendString:@"["];
    [description appendString:[values componentsJoinedByString:@", "]];
    if (self.length > printedLength) {
        [description appendFormat:@", ... %lu more", self.length - printedLength];
    }
    [description appendString:@"]"];
    return description;
}


- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ %p: %lu values %@>", self.class, self, self.length, self];
}



@end


