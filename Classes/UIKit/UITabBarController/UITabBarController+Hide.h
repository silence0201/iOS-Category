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

- (void)setTabBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion;

@end
