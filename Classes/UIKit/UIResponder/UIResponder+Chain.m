//
//  UIResponder+Chain.m
//  Category
//
//  Created by Silence on 2017/3/21.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIResponder+Chain.h"

@implementation UIResponder (Chain)

- (NSString *)responderChainDescription
{
    NSMutableArray *responderChainStrings = [NSMutableArray array];
    [responderChainStrings addObject:[self class]];
    UIResponder *nextResponder = self;
    while ((nextResponder = [nextResponder nextResponder])) {
        [responderChainStrings addObject:[nextResponder class]];
    }
    __block NSString *returnString = @"Responder Chain:\n";
    __block int tabCount = 0;
    [responderChainStrings enumerateObjectsWithOptions:NSEnumerationReverse
                                            usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                if (tabCount) {
                                                    returnString = [returnString stringByAppendingString:@"|"];
                                                    for (int i = 0; i < tabCount; i++) {
                                                        returnString = [returnString stringByAppendingString:@"----"];
                                                    }
                                                    returnString = [returnString stringByAppendingString:@" "];
                                                }
                                                else {
                                                    returnString = [returnString stringByAppendingString:@"| "];
                                                }
                                                returnString = [returnString stringByAppendingFormat:@"%@ (%@)\n", obj, @(idx)];
                                                tabCount++;
                                            }];
    return returnString;
}


@end
