//
//  UIImage+Tint.m
//  Category
//
//  Created by Silence on 2019/5/5.
//  Copyright © 2019年 silence. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

// Tint: Color
-(UIImage*)tintedImageWithColor:(UIColor*)color {
    return [self tintedImageWithColor:color level:1.0f];
}

// Tint: Color + level
-(UIImage*)tintedImageWithColor:(UIColor*)color level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self tintedImageWithColor:color rect:rect level:level];
}

// Tint: Color + Rect
-(UIImage*)tintedImageWithColor:(UIColor*)color rect:(CGRect)rect {
    return [self tintedImageWithColor:color rect:rect level:1.0f];
}

// Tint: Color + Rect + level
-(UIImage*)tintedImageWithColor:(UIColor*)color rect:(CGRect)rect level:(CGFloat)level {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, level);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

// Tint: Color + Insets
-(UIImage*)tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets {
    return [self tintedImageWithColor:color insets:insets level:1.0f];
}

// Tint: Color + Insets + level
-(UIImage*)tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets level:(CGFloat)level {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) level:level];
}

// Light: Level
-(UIImage*)lightenWithLevel:(CGFloat)level {
    return [self tintedImageWithColor:[UIColor whiteColor] level:level];
}

// Light: Level + Insets
-(UIImage*)lightenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self tintedImageWithColor:[UIColor whiteColor] insets:insets level:level];
}

// Light: Level + Rect
-(UIImage*)lightenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self tintedImageWithColor:[UIColor whiteColor] rect:rect level:level];
}

// Dark: Level
-(UIImage*)darkenWithLevel:(CGFloat)level {
    return [self tintedImageWithColor:[UIColor blackColor] level:level];
}

// Dark: Level + Insets
-(UIImage*)darkenWithLevel:(CGFloat)level insets:(UIEdgeInsets)insets {
    return [self tintedImageWithColor:[UIColor blackColor] insets:insets level:level];
}

// Dark: Level + Rect
-(UIImage*)darkenRect:(CGRect)rect withLevel:(CGFloat)level {
    return [self tintedImageWithColor:[UIColor blackColor] rect:rect level:level];
}

@end
