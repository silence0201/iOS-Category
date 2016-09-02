//
//  UILabel+SIReSize.h
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SIReSize)


/**
 *  自适应Label
 *
 *  @param frame        frame
 *  @param text         文字内容
 *  @param textColor    文字颜色
 *  @param font         文字字体
 *  @param numberOfLine 行数
 *
 *  @return 实例
 */
+ (instancetype)SI_labelAdaptiveWithFrame:(CGRect)frame
                                     text:(NSString *)text
                               titleColor:(UIColor *)textColor
                                     font:(UIFont *)font
                             numberOfLine:(NSInteger)numberOfLine ;

@end
