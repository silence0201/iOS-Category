//
//  NSArray+Contains.m
//  Category
//
//  Created by Silence on 19/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "NSArray+Contains.h"

@implementation NSArray (Contains)

-(BOOL)containsAll:(NSArray *)array{
    for( id obj in array ) {
        if( ![self containsObject:obj] ) {
            return false;
        }
    }
    return true;
}

-(BOOL)containsAny:(NSArray *)array{
    for( id obj in array ) {
        if( [self containsObject:obj] ) {
            return true;
        }
    }
    return false;
}

@end
