//
//  NSString+Size.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 文字的Size

 @param font 字体
 @param maxSize MaxSize
 @return 文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize ;

/**
 文字的Size

 @param text 文字
 @param font 字体
 @param maxSize MaxSize
 @return 文字的Size
 */
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize ;


/**
 文字的高度

 @param font 字体
 @param width 限制的宽度
 @return 文字的高度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 文字的宽度

 @param font 字体
 @param height 限制的高度
 @return 文字的宽度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;


/**
 文字的Size

 @param font 字体
 @param width 容器的宽度
 @return 文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 文字的Size

 @param font 字体
 @param height 容器的高度
 @return 文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

@end
