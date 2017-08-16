//
//  UIViewController+Visible.m
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIViewController+Visible.h"

@implementation UIViewController (Visible)

- (BOOL)isVisible {
    return [self isViewLoaded] && self.view.window;
}

@end
