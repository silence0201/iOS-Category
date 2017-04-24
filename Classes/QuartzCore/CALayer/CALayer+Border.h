//
//  CALayer+Border.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (Border)

@property(nonatomic, assign) UIColor *borderColor;

+ (CALayer *)roundCorneredLayerForBounds:(CGRect)rect
                       withTopLeftRadius:(CGFloat)topLeft
                      withTopRightRadius:(CGFloat)topRight
                    withBottomLeftRadius:(CGFloat)bottomLeft
                   withBottomRightRadius:(CGFloat)bottomRight;


@end
