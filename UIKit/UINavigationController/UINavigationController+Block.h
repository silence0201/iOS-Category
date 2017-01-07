//
//  UINavigationController+Block.h
//  Category
//
//  Created by 杨晴贺 on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Block)

- (id)initWithRootViewController:(UIViewController*)rootViewController navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden;
- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated navigationBarHidden:(BOOL)navigationBarHidden toolBarHidden:(BOOL)toolBarHidden completion:(void(^)(void))completion back:(void(^)(void))back;
- (UIViewController*)popViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
- (NSArray*)popToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;
- (NSArray*)popToViewController:(UIViewController*)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

@end
