//
//  NSString+Contains.m
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSString+Contains.h"

@implementation NSString (Contains)

- (BOOL)isContainChinese{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isContainBlank{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}



- (BOOL)containsCharacterSet:(NSCharacterSet *)set{
    NSRange rang = [self rangeOfCharacterFromSet:set];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)containsString:(NSString *)string{
    NSRange rang = [self rangeOfString:string];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

/**获取字符数量*/
- (int)wordsCount{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++){
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}


@end
