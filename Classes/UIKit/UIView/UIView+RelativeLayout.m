//
//  UIView+RelativeLayout.m
//  Category
//
//  Created by Silence on 2017/11/23.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIView+RelativeLayout.h"

@implementation UIView (RelativeLayout)

- (void)layoutRelativeOptions:(UIViewLayout)options withView:(UIView *)view{
    [self layoutRelativeOptions:options withView:view padding:UIEdgeInsetsZero];
}

- (void)layoutRelativeOptions:(UIViewLayout)options withView:(UIView *)view padding:(UIEdgeInsets)padding{
    [self layoutRelativeOptions:options withRect:view.frame padding:padding];
}

- (void)layoutRelativeOptions:(UIViewLayout)options withRect:(CGRect)rect{
    [self layoutRelativeOptions:options withRect:rect padding:UIEdgeInsetsZero];
}

- (void)layoutRelativeOptions:(UIViewLayout)options withRect:(CGRect)rect padding:(UIEdgeInsets)padding{
    CGRect frame = self.frame;
    CGRect superFrame = self.superview.frame;
    
    CGFloat minX = NAN;
    CGFloat maxX = NAN;
    if (options & UIViewLayoutRightOf) {
        minX = CGRectGetMaxX(rect) + padding.left;
    }
    else if (options & UIViewLayoutAlignLeft) {
        minX = CGRectGetMinX(rect) + padding.left;
    }
    else if (options & UIViewLayoutAlignSuperviewLeft) {
        minX = 0 + padding.left;
    }
    
    if (options & UIViewLayoutLeftOf) {
        maxX = CGRectGetMinX(rect) - padding.right;
    }
    else if (options & UIViewLayoutAlignRight) {
        maxX = CGRectGetMaxX(rect) - padding.right;
    }
    else if (options & UIViewLayoutAlignSuperviewRight) {
        maxX = CGRectGetWidth(superFrame) - padding.right;
    }
    
    if (!isnan(minX) && !isnan(maxX)) {
        frame.size.width = maxX - minX;
        frame.origin.x = minX;
    }
    else if (!isnan(minX)) {
        frame.origin.x = minX;
    }
    else if (!isnan(maxX)) {
        frame.origin.x = maxX - CGRectGetWidth(frame);
    }
    
    CGFloat minY = NAN;
    CGFloat maxY = NAN;
    if (options & UIViewLayoutBelow) {
        minY = CGRectGetMaxY(rect) + padding.top;
    }
    else if (options & UIViewLayoutAlignTop) {
        minY = CGRectGetMinY(rect) + padding.top;
    }
    else if (options & UIViewLayoutAlignSuperviewTop) {
        minY = 0 + padding.top;
    }
    
    if (options & UIViewLayoutAbove) {
        maxY = CGRectGetMinY(rect) - padding.bottom;
    }
    else if (options & UIViewLayoutAlignBottom) {
        maxY = CGRectGetMaxY(rect) - padding.bottom;
    }
    else if (options & UIViewLayoutAlignSuperviewBottom) {
        maxY = CGRectGetHeight(superFrame) - padding.bottom;
    }
    
    if (!isnan(minY) && !isnan(maxY)) {
        frame.size.height = maxY - minY;
        frame.origin.y = minY;
    }
    else if (!isnan(minY)) {
        frame.origin.y = minY;
    }
    else if (!isnan(maxY)) {
        frame.origin.y = maxY - CGRectGetHeight(frame);
    }
    
    if (options & UIViewLayoutCenterHorizontal) {
        frame.origin.x = CGRectGetMinX(rect) + CGRectGetWidth(rect)/2 - CGRectGetWidth(frame)/2 + padding.left - padding.right;
    }
    else if (options & UIViewLayoutCenterHorizontalInSuperview) {
        frame.origin.x = 0 + CGRectGetWidth(superFrame)/2 - CGRectGetWidth(frame)/2 + padding.left - padding.right;
    }
    if (options & UIViewLayoutCenterVertical) {
        frame.origin.y = CGRectGetMinY(rect) + CGRectGetHeight(rect)/2 - CGRectGetHeight(frame)/2 + padding.top - padding.bottom;
    }
    else if (options & UIViewLayoutCenterVerticalInSuperview) {
        frame.origin.y = 0 + CGRectGetHeight(superFrame)/2 - CGRectGetHeight(frame)/2 + padding.top - padding.bottom;
    }
    
    self.frame = frame;
}

@end
