//
//  UITabBarController+Hide.h
//  HIdeDemo
//
//  Created by 杨晴贺 on 17/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Hide)

@property (nonatomic,getter=isTabBarHidden,readonly) BOOL tabBarHidden ;


/**
 设置Tabbar隐藏

 @param hidden 是否隐藏
 @param animated 是否有动画
 @param completion 返回回调
 */
- (void)setTabBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion;

@end
