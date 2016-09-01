//
//  UIButton+SIButtonBlock.h
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonActionBlock) (UIButton *btn);

@interface UIButton (SIButtonBlock)
/**
 *  简单创建按钮
 *
 *  @param frame frame
 *  @param title title
 *  @param color 文字颜色
 *  @param block block回调
 *
 *  @return 按钮对象
 */
+ (instancetype)SI_buttonCustomButtonFrame:(CGRect)frame
                                     title:(NSString *)title
                         currentTitleColor:(UIColor *)color
                               actionBlock:(ButtonActionBlock) block ;

/**
 *  图片button
 *
 *  @param frame     frame
 *  @param imageName 默认图片
 *  @param block     block回调
 *
 *  @return 按钮对象
 */
+ (instancetype)SI_buttonCustomButtonFrame:(CGRect)frame
                           normalImageName:(NSString *)imageName
                               actionBlock:(ButtonActionBlock) block ;

@end
