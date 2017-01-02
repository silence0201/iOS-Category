//
//  UIImage+GIF.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GIF)

/// 用一个Gif生成UIImage，传入一个GIFData
+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)theData;

/// 用一个Gif生成UIImage，传入一个GIF路径
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)theURL;

/// 用一个Gif生成UIImage，传入一个GIF名字
+ (UIImage *)animatedImageWithAnimatedGIFNamed:(NSString *)name;

- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
