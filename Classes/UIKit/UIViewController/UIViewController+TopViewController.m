//
//  UIViewController+TopViewController.m
//  Category
//
//  Created by Silence on 2019/8/5.
//  Copyright © 2019年 silence. All rights reserved.
//

#import "UIViewController+TopViewController.h"

@implementation UIViewController (TopViewController)

- (UIViewController *)topViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self.class topViewController:rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        return [self topViewController:viewController.presentedViewController];
        
    } else if([viewController isKindOfClass:UINavigationController.class]) {
        UINavigationController *navigationController = (UINavigationController *) viewController;
        return [self topViewController:navigationController.visibleViewController];
        
    } else if([viewController isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        return [self topViewController:tabBarController.selectedViewController];
        
    } else {
        return viewController;
    }
}

- (void)presentViewControllerOnTopAnimated: (BOOL)flag completion:(void (^ __nullable)(void))completion {
    UIViewController *topViewController = [self topViewController];
    [topViewController presentViewController:self animated:flag completion:completion];
}

@end
