//
//  UIView+Skeleton.m
//  SkeletonViewDemo
//
//  Created by Silence on 2018/1/3.
//  Copyright © 2018年 Silence. All rights reserved.
//

#import "UIView+Skeleton.h"
#import <objc/runtime.h>

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue)   UIColorFromRGBA(rgbValue, 1.0)

#define SomoColorFromRGBA(R, G, B, A) \
[UIColor  colorWithRed:(R)/255.0 \
green:(G)/255.0 \
blue:(B)/255.0 \
alpha:1.0]

#define SomoColorFromRGB(R, G, B)        SomoColorFromRGBA(R, G, B, 1.0)
#define SomoColorFromRGBV(V)        SomoColorFromRGBA(V, V, V, 1.0)

static const CGFloat kShadowWidth = 60.;

@interface Skeleton()

@property (strong, nonatomic) CAGradientLayer *somoLayer;

@end

@implementation Skeleton

- (instancetype)initWithFrame:(CGRect)rect somoColor:(UIColor *)color{
    return [[[self class] alloc] initWithFrame:rect
                                     somoColor:color
                                animationStyle:SkeletonAnimationStyleSolid];
}

- (instancetype)initWithFrame:(CGRect)rect
                    somoColor:(UIColor *)color
               animationStyle:(SkeletonAnimationStyle)style{
    if (self = [super initWithFrame:rect]) {
        [self _setup];
        _skeletonColor = color;
        _animationStyle = style;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setAnimationStyle:(SkeletonAnimationStyle)animationStyle{
    if (_animationStyle != animationStyle) {
        _animationStyle = animationStyle;
        [self.somoLayer removeFromSuperlayer];
        [self _animate];
    }
}

- (void)_setup{
    _skeletonColor = SomoColorFromRGBV(150);
    _animationStyle = SkeletonAnimationStyleGradientVertical;
    self.backgroundColor = self.skeletonColor;
    self.layer.masksToBounds = YES;
    [self _animate];
}

- (void)_animate{
    CGSize size = self.bounds.size;
    switch (self.animationStyle) {
        case SkeletonAnimationStyleSolid:{
            CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"opacity"];
            basic.fromValue = @1.;
            basic.toValue = @0.5;
            basic.duration = 2.;
            basic.repeatCount = INFINITY;
            basic.autoreverses = YES;
            basic.removedOnCompletion = NO;
            [self.layer addAnimation:basic forKey:basic.keyPath];
            break;
        }
        case SkeletonAnimationStyleGradientHorizontal:{
            CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"position"];
            basic.fromValue = [NSValue valueWithCGPoint:CGPointMake(-kShadowWidth/2., size.height/2.)];
            basic.toValue = [NSValue valueWithCGPoint:CGPointMake(size.width+kShadowWidth/2., size.height/2.)];
            basic.duration = 1.5;
            basic.repeatCount = INFINITY;
            basic.removedOnCompletion = NO;
            self.somoLayer.frame = CGRectMake(0, 0, kShadowWidth, size.height);
            self.somoLayer.startPoint = CGPointMake(0, 0.5);
            self.somoLayer.endPoint = CGPointMake(1, 0.5);
            [self.somoLayer addAnimation:basic forKey:basic.keyPath];
            [self.layer addSublayer:self.somoLayer];
            break;
        }
        case SkeletonAnimationStyleGradientVertical:{
            CGFloat height = size.height/2. > 40. ? : 40.;
            CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"position"];
            basic.fromValue = [NSValue valueWithCGPoint:CGPointMake(size.width/2., -height)];
            basic.toValue = [NSValue valueWithCGPoint:CGPointMake(size.width/2., size.height+height)];
            basic.duration = 1.5;
            basic.repeatCount = INFINITY;
            basic.removedOnCompletion = NO;
            self.somoLayer.frame = CGRectMake(0,0,size.width,height);
            self.somoLayer.startPoint = CGPointMake(0.5, 0);
            self.somoLayer.endPoint = CGPointMake(0.5, 1);
            [self.somoLayer addAnimation:basic forKey:basic.keyPath];
            [self.layer addSublayer:self.somoLayer];
            break;
        }
        case SkeletonAnimationStyleOblique:{
            CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"position"];
            basic.fromValue = [NSValue valueWithCGPoint:CGPointMake(-kShadowWidth, size.height/2.)];
            basic.toValue = [NSValue valueWithCGPoint:CGPointMake(size.width+kShadowWidth, size.height/2.)];
            basic.duration = 1.5;
            basic.repeatCount = INFINITY;
            basic.removedOnCompletion = NO;
            self.somoLayer.affineTransform = CGAffineTransformMakeRotation(0.4);
            self.somoLayer.frame = CGRectMake(0, 0, kShadowWidth, size.height+200);
            self.somoLayer.startPoint = CGPointMake(0, 0.5);
            self.somoLayer.endPoint = CGPointMake(1, 0.5);
            [self.somoLayer addAnimation:basic forKey:basic.keyPath];
            [self.layer addSublayer:self.somoLayer];
            break;
        }
        default:
            break;
    }
}

-(CAGradientLayer *)somoLayer{
    if (!_somoLayer) {
        _somoLayer = [CAGradientLayer layer];
        UIColor * color = [UIColor whiteColor];
        _somoLayer.colors = @[(id)[color colorWithAlphaComponent:0.03].CGColor,
                              (id)[color colorWithAlphaComponent:0.09].CGColor,
                              (id)[color colorWithAlphaComponent:0.15].CGColor,
                              (id)[color colorWithAlphaComponent:0.21].CGColor,
                              (id)[color colorWithAlphaComponent:0.27].CGColor,
                              (id)[color colorWithAlphaComponent:0.30].CGColor,
                              (id)[color colorWithAlphaComponent:0.27].CGColor,
                              (id)[color colorWithAlphaComponent:0.21].CGColor,
                              (id)[color colorWithAlphaComponent:0.15].CGColor,
                              (id)[color colorWithAlphaComponent:0.09].CGColor,
                              (id)[color colorWithAlphaComponent:0.03].CGColor];
    }
    return _somoLayer;
}

@end

@implementation UIView (Skeleton)

- (UIView *)skeletonContainer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSkeletonContainer:(UIView *)skeletonContainer {
    skeletonContainer.frame = self.bounds;
    UIColor *color = SomoColorFromRGBV(248.);
    if ([self respondsToSelector:@selector(containerBackgroundColor)]) {
        color = [(UIView<SkeletonLayoutProtocol> *)self containerBackgroundColor];
    }
    skeletonContainer.backgroundColor = color;
    [self addSubview:skeletonContainer];
    objc_setAssociatedObject(self, @selector(skeletonContainer), skeletonContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)beginSkeleton {
    if (![self conformsToProtocol:@protocol(SkeletonLayoutProtocol)]) return;
    if (![self respondsToSelector:@selector(skeletonLayout)]) return;
    self.userInteractionEnabled = NO;
    [self.skeletonContainer removeFromSuperview];
    self.skeletonContainer = nil;
    self.skeletonContainer = [UIView new];
    [self bringSubviewToFront:self.skeletonContainer];
    NSArray<Skeleton *> *skeletonViews = [(UIView<SkeletonLayoutProtocol> *)self skeletonLayout];
    for (Skeleton *view in skeletonViews) {
        [self.skeletonContainer addSubview:view];
    }
}

- (void)endSkeleton {
    if (!self.skeletonContainer) return;
    self.userInteractionEnabled = YES;
    [self.skeletonContainer removeFromSuperview];
    self.skeletonContainer = nil;
}

@end
