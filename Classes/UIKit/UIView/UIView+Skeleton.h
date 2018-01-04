//
//  UIView+Skeleton.h
//  SkeletonViewDemo
//
//  Created by Silence on 2018/1/3.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SkeletonAnimationStyle) {
    SkeletonAnimationStyleSolid,
    SkeletonAnimationStyleGradientHorizontal,
    SkeletonAnimationStyleGradientVertical,
    SkeletonAnimationStyleOblique
};

@class Skeleton;
@protocol SkeletonLayoutProtocol<NSObject>
@required
- (NSArray<Skeleton *> *)skeletonLayout;

@optional
- (UIColor *)containerBackgroundColor;

@end

@interface Skeleton: UIView

@property (strong, nonatomic) UIColor *skeletonColor;
@property (assign, nonatomic) SkeletonAnimationStyle animationStyle;

- (instancetype)initWithFrame:(CGRect)rect
                    somoColor:(UIColor *)color;

- (instancetype)initWithFrame:(CGRect)rect
                    somoColor:(UIColor *)color
               animationStyle:(SkeletonAnimationStyle)style;

@end

@interface UIView (Skeleton)

@property (strong,nonatomic,readonly) UIView *skeletonContainer;

- (void)beginSkeleton;

- (void)endSkeleton;

@end
