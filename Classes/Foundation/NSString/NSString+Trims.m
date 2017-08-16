//
//  NSString+Trims.m
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSString+Trims.h"

@implementation NSString (Trims)

- (NSString *)stringByStrippingHTML {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByRemovingScriptsAndStrippingHTML {
    NSMutableString *mString = [self mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString stringByStrippingHTML];
}

- (NSString *)trimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimmingWhitespaceAndNewlines{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
