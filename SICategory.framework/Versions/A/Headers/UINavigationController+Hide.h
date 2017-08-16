//
//  UINavigationController+Hide.h
//  HIdeDemo
//
//  Created by Silence on 17/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Hide)

@property (nonatomic,getter=isNavBarHidden,readonly) BOOL navBarHidden ; /// 导航栏是否隐藏


/**
 设置NavBar隐藏

 @param hidden Hidden
 @param animated 是否有动画
 @param completion 完成回调
 */
- (void)setNavBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion;

@end
