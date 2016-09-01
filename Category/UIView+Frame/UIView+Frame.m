//
//  UIView+Frame.m
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

/**
 *  简便赋值Size
 *
 *  @param size 要改变为的Size
 */
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

/**
 *  简便获取Size
 *
 *  @return View的Size
 */
-(CGSize)size{
    return self.frame.size;
}

/**
 *  简便赋值Origin
 *
 *  @param origin 要改变为的Origin
 */
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

/**
 *  简便获取Origin
 *
 *  @return View的Size
 */
- (CGPoint)origin{
    return self.frame.origin;
}

/**
 *  简便赋值View的Width
 *
 *  @param width 要改变为的Width
 */
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/**
 *  简便获取View的Width
 *
 *  @return View的Width
 */
-(CGFloat)width{
    return self.frame.size.width;
}

/**
 *  简便赋值View的Height
 *
 *  @param height 要改变为的Height
 */
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/**
 *  简便获取View的Height
 *
 *  @return View的Height
 */
- (CGFloat)height{
    return self.frame.size.height;
}

/**
 *  简便获取View的横坐标
 *
 *  @return View的横坐标
 */
- (CGFloat)x{
    return self.frame.origin.x;
}

/**
 *  简便赋值View的横坐标
 *
 *  @param x 要改变为的横坐标
 */
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


/**
 *  简便获取View的y坐标
 *
 *  @return View的y坐标
 */
- (CGFloat)y{
    return self.frame.origin.y;
}

/**
 *  简便赋值View的y坐标
 *
 *  @param y 要改变为的y坐标
 */
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/**
 *  简便获取View的中心坐标X值
 *
 *  @return View的中心坐标X值
 */
- (CGFloat)centerX{
    return self.center.x;
}

/**
 *  简便赋值View的中心坐标X值
 *
 *  @param centerX 要改变为的中心坐标X值
 */
- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

/**
 *  简便获取View的中心坐标Y值
 *
 *  @return View的中心坐标Y值
 */
- (CGFloat)centerY{
    return self.center.y;
}

/**
 *  简便赋值View的中心坐标Y值
 *
 *  @param centerY 要改变为的中心坐标Y值
 */
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}



@end
