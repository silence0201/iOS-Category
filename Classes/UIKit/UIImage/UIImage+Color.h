//
//  UIImage+Color.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size ;
+ (UIImage *)imageWithColor:(UIColor *)color ;

- (UIColor *)colorAtPoint:(CGPoint )point ;
- (UIColor *)colorAtPixel:(CGPoint)point ;

- (BOOL)hasAlphaChannel ;

+ (UIImage *)grayImageFromImage:(UIImage*)sourceImage ;
- (UIImage *)grayImage ;

@end
