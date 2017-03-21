//
//  UIResponder+FirstResponder.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/21.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (FirstResponder)

/**
 *  @brief  当前第一响应者
 *
 *  @return 当前第一响应者
 */
+ (id)currentFirstResponder;

@end
