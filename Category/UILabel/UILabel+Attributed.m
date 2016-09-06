//
//  UILabel+Attributed.m
//  Category
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UILabel+Attributed.h"

@implementation UILabel (Attributed)

- (void)si_setAttributedWithString:(NSString *)str
                AndAttributedColor:(UIColor *)attributeColor
                   AndAttriuteFont:(UIFont *)attributedFont{
    NSRange rang = [self.text rangeOfString:str] ;
    
    UIColor *cuttentColor = attributeColor ? attributeColor:self.textColor ;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:self.text] ;
    
    [string addAttribute:NSForegroundColorAttributeName value:cuttentColor range:rang] ;
    if(attributedFont){
        [string addAttribute:NSFontAttributeName value:attributedFont range:rang];
    }
    self.attributedText = string ;
}

@end
