//
//  UIImage+Sprite.m
//  Category
//
//  Created by Silence on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIImage+Sprite.h"

@implementation UIImage (Sprite)

- (NSArray *)spritesWithSpriteSheetImage:(UIImage *)image
                              spriteSize:(CGSize)size{
    return [self spritesWithSpriteSheetImage:self
                                     inRange:NSMakeRange(0, lroundf(MAXFLOAT))
                                  spriteSize:size];
}


- (NSArray *)spritesWithSpriteSheetImage:(UIImage *)image
                                 inRange:(NSRange)range
                              spriteSize:(CGSize)size{
    if (!image || CGSizeEqualToSize(size, CGSizeZero) || range.length == 0)
    {
        return nil;
    }
    
    CGImageRef spriteSheet = [image CGImage];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    CGFloat width = CGImageGetWidth(spriteSheet);
    CGFloat height = CGImageGetHeight(spriteSheet);
    
    NSUInteger maxI = (NSUInteger)(width / size.width);
    
    NSUInteger startI = 0;
    NSUInteger startJ = 0;
    NSUInteger length = 0;
    
    NSUInteger startPosition = range.location;
    
    // Extracting initial I & J values from range info
    if (startPosition != 0)
    {
        for (int k=1; k<=maxI; k++)
        {
            NSUInteger d = k * maxI;
            
            if (d/startPosition == 1)
            {
                startI = maxI - (d % startPosition);
                break;
            }
            else if (d/startPosition > 1)
            {
                startI = startPosition;
                break;
            }
            
            startJ++;
        }
    }
    
    CGFloat positionX = startI * size.width;
    CGFloat positionY = startJ * size.height;
    BOOL isReady = NO;
    
    while (positionY < height)
    {
        while (positionX < width)
        {
            CGImageRef sprite = CGImageCreateWithImageInRect(spriteSheet,
                                                             CGRectMake(positionX,
                                                                        positionY,
                                                                        size.width,
                                                                        size.height));
            [tempArray addObject:[UIImage imageWithCGImage:sprite]];
            
            CGImageRelease(sprite);
            
            length++;
            
            if (length == range.length)
            {
                isReady = YES;
                break;
            }
            
            positionX += size.width;
        }
        
        if (isReady) break;
        
        positionX = 0;
        positionY += size.height;
    }
    
    return [NSArray arrayWithArray:tempArray];
}

@end
