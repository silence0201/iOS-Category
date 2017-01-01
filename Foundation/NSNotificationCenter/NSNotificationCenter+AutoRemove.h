//
//  NSNotificationCenter+AutoRemove.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (AutoRemove)

/// 设置是否自动移除监听
+ (void)setNotificationAutoRemoveEnable:(BOOL)enable;
/// 获取自动移除监听是否开启
+ (BOOL)notificationAutoRemoveEnable;

@end
