//
//  UINavigationController+Stack.m
//  Category
//
//  Created by 杨晴贺 on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UINavigationController+Stack.h"

@implementation UINavigationController (Stack)

- (id)findViewController:(Class)className;{
    for (UIViewController *viewController in self.viewControllers){
        if ([viewController isKindOfClass:className]){
            return viewController;
        }
    }
    return nil;
}

- (BOOL)isOnlyContainRootViewController{
    if (self.viewControllers && self.viewControllers.count == 1){
        return YES;
    }
    return NO;
}

- (UIViewController *)rootViewController{
    if (self.viewControllers && [self.viewControllers count] >0){
        return [self.viewControllers firstObject];
    }
    return nil;
}

- (NSArray *)popToViewControllerWithClassName:(Class)className animated:(BOOL)animated;{
    return [self popToViewController:[self findViewController:className] animated:YES];
}

- (NSArray *)popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated{
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}


@end
