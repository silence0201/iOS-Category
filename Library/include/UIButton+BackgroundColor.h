//
//  UIButton+BackgroundColor.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BackgroundColor)


/**
 给按钮设置背景颜色

 @param backgroundColor Color
 @param state 按钮的状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
