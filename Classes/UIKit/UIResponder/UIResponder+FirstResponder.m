//
//  UIResponder+FirstResponder.m
//  Category
//
//  Created by Silence on 2017/3/21.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIResponder+FirstResponder.h"

static __weak id currentFirstResponder;
@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

- (void)findCurrentFirstResponder:(id)sender {
    currentFirstResponder = self;
}

@end
