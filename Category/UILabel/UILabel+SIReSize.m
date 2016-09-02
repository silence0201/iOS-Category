//
//  UILabel+SIReSize.m
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UILabel+SIReSize.h"

@implementation UILabel (SIReSize)

+ (instancetype)SI_labelAdaptiveWithFrame:(CGRect)frame
                                     text:(NSString *)text
                               titleColor:(UIColor *)textColor
                                     font:(UIFont *)font
                             numberOfLine:(NSInteger)numberOfLine{
    UILabel *label = [[UILabel alloc]initWithFrame:frame] ;
    // NSLineBreakByWordWrapping = 0  -->以空格为界，保留整个单词。
    // NSLineBreakByCharWrapping -->保留整个字符
    // NSLineBreakByClipping -->简单剪裁，到边界为止
    // NSLineBreakByTruncatingHead -->前面部分文字以……方式省略，显示尾部文字内容
    // NSLineBreakByTruncatingTail -->结尾部分的内容以……方式省略，显示头的文字内容。
    // NSLineBreakByTruncatingMiddle -->中间的内容以……方式省略，显示头尾的文字内容。
    label.lineBreakMode = NSLineBreakByWordWrapping ;
    label.numberOfLines = numberOfLine ;
    label.textColor = textColor ;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text] ;
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init] ;
    para.lineSpacing = 5.0f ;
    [str addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, text.length)] ;
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)] ;
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)] ;
    frame = label.frame ;
    frame.size.height = size.height ;
    label.frame = frame ;
    return label ;
    
}

@end
