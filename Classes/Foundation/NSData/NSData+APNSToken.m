//
//  NSData+APNSToken.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSData+APNSToken.h"

@implementation NSData (APNSToken)

- (NSString *)APNSToken {
    return [[[[self description]
              stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}


@end
