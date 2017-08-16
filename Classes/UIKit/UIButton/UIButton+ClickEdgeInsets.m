//
//  UIButton+ClickEdgeInsets.m
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIButton+ClickEdgeInsets.h"
#import <objc/runtime.h>

@implementation UIButton (ClickEdgeInsets)

- (UIEdgeInsets)clickEdgeInsets{
    return [objc_getAssociatedObject(self, @selector(clickEdgeInsets)) UIEdgeInsetsValue];
}

- (void)setClickEdgeInsets:(UIEdgeInsets)clickEdgeInsets{
    objc_setAssociatedObject(self, @selector(clickEdgeInsets), [NSValue valueWithUIEdgeInsets:clickEdgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (UIEdgeInsetsEqualToEdgeInsets(self.clickEdgeInsets, UIEdgeInsetsZero)){
        return [super pointInside:point withEvent:event];
    }else{
        CGRect large = UIEdgeInsetsInsetRect(self.bounds, self.clickEdgeInsets);
        return CGRectContainsPoint(large, point) ? YES : NO;
    }
}


@end
