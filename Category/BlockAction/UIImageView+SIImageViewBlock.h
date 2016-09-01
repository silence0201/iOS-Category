//
//  UIImageView+SIImageViewBlock.h
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageViewActionBlock) (UIImageView *image);

@interface UIImageView (SIImageViewBlock)

/**
 *  给imageView添加点击事件
 *
 *  @param frame imageView的Frame
 *  @param name  imageView的图片
 *  @param block 点击回调
 *
 *  @return ImageView实例
 */
+ (instancetype)SI_imageViewWithFrame:(CGRect)frame
                            imageName:(NSString *)name
                          clickAction:(ImageViewActionBlock)block ;

@end
