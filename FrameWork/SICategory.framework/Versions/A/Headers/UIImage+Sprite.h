//
//  UIImage+Sprite.h
//  Category
//
//  Created by Silence on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Useful UIImage category for handling sprite sheets. This add-on smoothes the way of extracting images from a sprite sheet (texture atlas).
 Note that for performance reasons you should not fire these methods every time you want to get the array of animation frames.
 You should rather fire it once and store the output array somewhere. This is because the Core Graphics image manipulation operations  (especially on large images) are not so fast and your application may slow down.
 */

@interface UIImage (Sprite)

/**
 The method returns an array with UIImages. Original sprite sheet is sliced into smaller chunks, each of the specified size.
 @param image the image with sprite sheet (texture atlas)
 @param size the size of the single chunk
 @returns the array of UIImages, each representing a single animation frame
 */
- (NSArray *)spritesWithSpriteSheetImage:(UIImage *)image
                              spriteSize:(CGSize)size;


/**
 The method returns an array with UIImages. Original sprite sheet is sliced into smaller chunks, each of the specified size.
 @param image the image with sprite sheet (texture atlas)
 @param range the range of the chunks
 @param size the size of the single chunk
 @returns the array of UIImages, each representing a single animation frame
 */
- (NSArray *)spritesWithSpriteSheetImage:(UIImage *)image
                                 inRange:(NSRange)range
                              spriteSize:(CGSize)size;

@end
