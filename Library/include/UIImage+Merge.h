//
//  UIImage+Merge.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Merge)

/**
 Merge Image

 @param firstImage 第一张图片
 @param secondImage 第二章图片
 @return Image
 */
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage ;

@end
