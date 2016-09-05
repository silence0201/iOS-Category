//
//  NSString+SIIsNull.m
//  Category
//
//  Created by 杨晴贺 on 9/5/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSString+SIIsNull.h"

@implementation NSString (SIIsNull)

- (id)si_isNull{
    if([self isKindOfClass:[NSNull class]]){
        return @"" ;
    }
    return self ;
}

@end
