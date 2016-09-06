//
//  UILabel+Attributed.h
//  Category
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attributed)

/**
 *  富文本显示
 *
 *  @param str            需要那些文本进行显示
 *  @param attributeColor 需要改变字符的颜色
 *  @param attributedFont 需要改变字符的字体
 */
- (void)si_setAttributedWithString:(NSString *)str
                AndAttributedColor:(UIColor *)attributeColor
                   AndAttriuteFont:(UIFont *)attributedFont ;

@end
