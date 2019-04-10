//
//  UIImage+Capture.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Capture)

/**
 截取View生成图片

 @param view 视图
 @return 生成的图片
 */
+ (UIImage *)captureWithView:(UIView *)view ;

/// 对图片进行缩放
+ (UIImage *)imageWithSize:(CGRect)myImageRect FromImage:(UIImage *)bigImage;

@end
