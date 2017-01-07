//
//  UIImage+Capture.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Capture)

+ (UIImage *)captureWithView:(UIView *)view ;
+ (UIImage *)imageWithSize:(CGRect)myImageRect FromImage:(UIImage *)bigImage;

@end
