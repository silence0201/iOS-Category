//
//  UIWindow+Hierarchy.m
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIWindow+Hierarchy.h"

@implementation UIWindow (Hierarchy)
- (UIViewController*)topMostController{
    UIViewController *topController = [self rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    return topController;
}

- (UIViewController*)currentViewController;{
    UIViewController *currentViewController = [self topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}
@end
