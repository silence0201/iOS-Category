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

#pragma mark --- GifDecoder / Gif简单解析
@interface GifFrame : NSObject

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) UIImage *image;

@end

@interface GifDecoder : NSObject

@property (nonatomic, assign, readonly) NSUInteger loopCount;//!< 动画循环次数 ,0 means infinite (default is 0)

+ (instancetype)decoderWithGIFNamed:(NSString *)name;
+ (instancetype)decoderWithData:(NSData *)data;


/**
 获取gif文件的图片信息
 
 @return GifFrame 的 NSArray
 */
- (NSArray<GifFrame *> *)contentImages;

/**
 获取gif文件的图片信息
 
 @return image
 */
- (UIImage *)gifImage;

@end
