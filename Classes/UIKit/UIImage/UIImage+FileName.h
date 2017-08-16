//
//  UIImage+FileName.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FileName)

/// 根据main bundle中的文件名读取图片
+ (UIImage *)imageWithFileName:(NSString *)name;

/// 根据指定bundle中的文件名读取图片
+ (UIImage *)imageWithFileName:(NSString *)name inBundle:(NSBundle*)bundle;

@end
