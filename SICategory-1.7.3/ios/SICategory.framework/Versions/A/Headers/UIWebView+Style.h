//
//  UIWebView+Style.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Style)

/**
 *  @brief  是否显示阴影
 *
 *  @param hidden 是否显示阴影
 */
- (void)shadowViewHidden:(BOOL)hidden;

/**
 *  @brief  是否显示水平滑动指示器
 *
 *  @param hidden 是否显示水平滑动指示器
 */
- (void)showsHorizontalScrollIndicator:(BOOL)hidden;
/**
 *  @brief  是否显示垂直滑动指示器
 *
 *  @param hidden 是否显示垂直滑动指示器
 */
- (void)showsVerticalScrollIndicator:(BOOL)hidden;

/**
 *  @brief  网页透明
 */
-(void)makeTransparent;
/**
 *  @brief  网页透明移除+阴影
 */
-(void)makeTransparentAndRemoveShadow;

@end
