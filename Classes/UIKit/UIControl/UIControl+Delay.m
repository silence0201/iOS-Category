//
//  UIControl+Delay.m
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIControl+Delay.h"
#import <objc/runtime.h>

@implementation UIControl (Delay)

+ (void)load{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(_sendAction:to:froEvent:));
    method_exchangeImplementations(a, b);
}

- (NSTimeInterval)acceptEventInterval{
    return [objc_getAssociatedObject(self, @selector(acceptEventInterval)) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval{
    objc_setAssociatedObject(self, @selector(acceptEventInterval), @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)_sendAction:(SEL)action to:(id)target froEvent:(UIEvent *)event{
    [self _sendAction:action to:target froEvent:event];
    self.userInteractionEnabled = NO;
    [self performSelector:@selector(setUserInteractionEnabled:) withObject:@(YES) afterDelay:self.acceptEventInterval];
    
}


@end
