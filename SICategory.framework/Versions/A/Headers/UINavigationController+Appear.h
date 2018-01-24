//
//  UINavigationController+Appear.h
//  Category
//
//  Created by Silence on 2017/12/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

/** item的位置 */
typedef NS_ENUM(NSInteger, SIBarItemOrientation) {
    SIBarItemOrientationLeft,
    SIBarItemOrientationRight
};

@interface UINavigationController (Appear)


/// 设置导航栏背景颜色
- (void)setBarBackgroundColor:(UIColor *)color;

/// 设置是否允许左滑返回
- (void)setInteractivePopGestureRecognizerEnable:(BOOL)enable;

/// 设置导航栏标题样式
- (void)setTitleColor:(UIColor *)color font:(UIFont *)font;

/// 设置导航栏背景图
- (void)setBarBackgroundImage:(NSString *)imageName;

/// 设置导航栏背景图
- (void)setBarTitle:(NSString *)title;

/// 设置导航栏背景图
- (void)setBarTitleView:(UIView *)view;

/// 添加item
- (UIButton *)addItemWithTitle:(NSString *)title
                     iconImage:(NSString *)iconImageName
               backgroundImage:(NSString *)backgroundImageName
                        target:(id)target
                        action:(SEL)action
                   orientation:(SIBarItemOrientation)orientation;

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem ;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem ;

/// 清空所有item
- (void)clearAllItem;

@end
