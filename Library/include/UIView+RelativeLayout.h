//
//  UIView+RelativeLayout.h
//  Category
//
//  Created by Silence on 2017/11/23.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, UIViewLayout) {
    UIViewLayoutAbove                   = 1,
    UIViewLayoutBelow                   = 1<<1,
    UIViewLayoutAlignBottom             = 1<<2,
    UIViewLayoutAlignTop                = 1<<3,
    UIViewLayoutAlignLeft               = 1<<4,
    UIViewLayoutAlignRight              = 1<<5,
    UIViewLayoutCenterVertical          = 1<<6,
    UIViewLayoutCenterHorizontal        = 1<<7,
    UIViewLayoutRightOf                 = 1<<8,
    UIViewLayoutLeftOf                  = 1<<9,
    
    // about super view
    UIViewLayoutAlignSuperviewBottom    = 1<<10,
    UIViewLayoutAlignSuperviewTop       = 1<<11,
    UIViewLayoutAlignSuperviewLeft      = 1<<12,
    UIViewLayoutAlignSuperviewRight     = 1<<13,
    UIViewLayoutCenterVerticalInSuperview   = 1<<14,
    UIViewLayoutCenterHorizontalInSuperview = 1<<15,
};

@interface UIView (RelativeLayout)

- (void)layoutRelativeOptions:(UIViewLayout)options withView:(UIView *)view;
- (void)layoutRelativeOptions:(UIViewLayout)options withView:(UIView *)view padding:(UIEdgeInsets)padding;

- (void)layoutRelativeOptions:(UIViewLayout)options withRect:(CGRect)rect;
- (void)layoutRelativeOptions:(UIViewLayout)options withRect:(CGRect)rect padding:(UIEdgeInsets)padding;


@end
