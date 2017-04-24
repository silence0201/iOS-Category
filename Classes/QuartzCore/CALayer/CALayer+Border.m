//
//  CALayer+Border.m
//  Category
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)

- (void)setBorderColor:(UIColor *)borderColor {
    self.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

+ (CALayer *)roundCorneredLayerForBounds:(CGRect)rect
                       withTopLeftRadius:(CGFloat)topLeft
                      withTopRightRadius:(CGFloat)topRight
                    withBottomLeftRadius:(CGFloat)bottomLeft
                   withBottomRightRadius:(CGFloat)bottomRight {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    
    if (context == NULL) {
        return NULL;
    }
    
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    
    CGContextBeginPath(context);
    CGContextSetGrayFillColor(context, 1.0, 0.0);
    CGContextAddRect(context, rect);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetGrayFillColor(context, 1.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, bottomLeft);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, bottomRight);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, topRight);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, topLeft);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    CGImageRef bitmapContext = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    CGImageRelease(bitmapContext);
    
    CALayer *overlayLayerMask = [CALayer layer];
    overlayLayerMask.frame = rect;
    overlayLayerMask.contents = (id)theImage.CGImage;
    return overlayLayerMask;
}

@end
