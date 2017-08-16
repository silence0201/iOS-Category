//
//  UIView+Badge.m
//  Category
//
//  Created by Silence on 2017/7/16.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIView+Badge.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, WAxis){
    WAxisX = 0,
    WAxisY,
    WAxisZ
};

#define kBadgeBreatheAniKey     @"breathe"
#define kBadgeRotateAniKey      @"rotate"
#define kBadgeShakeAniKey       @"shake"
#define kBadgeScaleAniKey       @"scale"
#define kBadgeBounceAniKey      @"bounce"

@implementation CAAnimation (WAnimation)

+(CABasicAnimation *)opacityForever_Animation:(float)time{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.1];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode=kCAFillModeForwards;
    return animation;
}


+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.4];
    animation.repeatCount=repeatTimes;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=YES;
    return  animation;
}


+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(WAxis)axis repeatCount:(int)repeatCount{
    CABasicAnimation* animation;
    NSArray *axisArr = @[@"transform.rotation.x", @"transform.rotation.y", @"transform.rotation.z"];
    animation = [CABasicAnimation animationWithKeyPath:axisArr[axis]];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue= [NSNumber numberWithFloat:degree];
    animation.duration= dur;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    
    return animation;
}


+(CABasicAnimation *)scaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale durTimes:(float)time rep:(float)repeatTimes{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(fromScale);
    animation.toValue = @(toScale);
    animation.duration = time;
    animation.autoreverses = YES;
    animation.repeatCount = repeatTimes;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}


+(CAKeyframeAnimation *)shake_AnimationRepeatTimes:(float)repeatTimes durTimes:(float)time forObj:(id)obj{
    NSAssert([obj isKindOfClass:[CALayer class]] , @"invalid target");
    CGPoint originPos = CGPointZero;
    CGSize originSize = CGSizeZero;
    if ([obj isKindOfClass:[CALayer class]]) {
        originPos = [(CALayer *)obj position];
        originSize = [(CALayer *)obj bounds].size;
    }
    CGFloat hOffset = originSize.width / 4;
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"position";
    anim.values=@[
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x-hOffset, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x+hOffset, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)]
                  ];
    anim.repeatCount = repeatTimes;
    anim.duration = time;
    anim.fillMode = kCAFillModeForwards;
    return anim;
}

+(CAKeyframeAnimation *)bounce_AnimationRepeatTimes:(float)repeatTimes durTimes:(float)time forObj:(id)obj{
    NSAssert([obj isKindOfClass:[CALayer class]] , @"invalid target");
    CGPoint originPos = CGPointZero;
    CGSize originSize = CGSizeZero;
    if ([obj isKindOfClass:[CALayer class]]) {
        originPos = [(CALayer *)obj position];
        originSize = [(CALayer *)obj bounds].size;
    }
    CGFloat hOffset = originSize.height / 4;
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"position";
    anim.values=@[
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y-hOffset)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y+hOffset)],
                  [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)]
                  ];
    anim.repeatCount=repeatTimes;
    anim.duration=time;
    anim.fillMode = kCAFillModeForwards;
    return anim;
}

@end

#define kWZLBadgeDefaultFont				([UIFont boldSystemFontOfSize:9])

#define kWZLBadgeDefaultMaximumBadgeNumber                     99
static const CGFloat kWZLBadgeDefaultRedDotRadius = 4.f;

@implementation UIView (Badge)

#pragma mark -- public methods
- (void)showBadge{
    [self showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
}

- (void)showBadgeWithStyle:(WBadgeStyle)style value:(NSInteger)value animationType:(WBadgeAnimType)aniType{
    self.aniType = aniType;
    switch (style) {
        case WBadgeStyleRedDot:
            [self showRedDotBadge];
            break;
        case WBadgeStyleNumber:
            [self showNumberBadgeWithValue:value];
            break;
        case WBadgeStyleNew:
            [self showNewBadge];
            break;
        default:
            break;
    }
    if (aniType != WBadgeAnimTypeNone) {
        [self beginAnimation];
    }
}

- (void)showNumberBadgeWithValue:(NSInteger)value animationType:(WBadgeAnimType)aniType {
    self.aniType = aniType;
    [self showNumberBadgeWithValue:value];
    
    if (aniType != WBadgeAnimTypeNone) {
        [self beginAnimation];
    }
}

- (void)clearBadge{
    self.badge.hidden = YES;
}

- (void)resumeBadge{
    if (self.badge && self.badge.hidden == YES) {
        self.badge.hidden = NO;
    }
}

- (void)showNumberBadgeWithValue:(NSInteger)value{
    if (value < 0) {
        return;
    }
    [self badgeInit];
    self.badge.hidden = (value == 0);
    self.badge.tag = WBadgeStyleNumber;
    self.badge.font = self.badgeFont;
    self.badge.text = (value > self.badgeMaximumBadgeNumber ?
                       [NSString stringWithFormat:@"%@+", @(self.badgeMaximumBadgeNumber)] :
                       [NSString stringWithFormat:@"%@", @(value)]);
    [self adjustLabelWidth:self.badge];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}

#pragma mark -- private methods
- (void)showRedDotBadge{
    [self badgeInit];
    if (self.badge.tag != WBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = WBadgeStyleRedDot;
        [self resetBadgeForRedDot];
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
    }
    self.badge.hidden = NO;
}

- (void)resetBadgeForRedDot {
    if (self.badgeRadius > 0) {
        self.badge.frame = CGRectMake(self.badge.center.x - self.badgeRadius, self.badge.center.y + self.badgeRadius , self.badgeRadius * 2, self.badgeRadius *2);
    }
}

- (void)showNewBadge{
    [self badgeInit];
    if (self.badge.tag != WBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = WBadgeStyleNew;
        
        CGRect frame = self.badge.frame;
        frame.size.width = 22;
        frame.size.height = 13;
        self.badge.frame = frame;
        
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.font = kWZLBadgeDefaultFont;
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 3;
    }
    self.badge.hidden = NO;
}



- (void)badgeInit{
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    
    if (nil == self.badge) {
        CGFloat redotWidth = kWZLBadgeDefaultRedDotRadius *2;
        CGRect frm = CGRectMake(CGRectGetWidth(self.frame), -redotWidth, redotWidth, redotWidth);
        self.badge = [[UILabel alloc] initWithFrame:frm];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.text = @"";
        self.badge.tag = WBadgeStyleRedDot;//red dot by default
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
        self.badge.layer.masksToBounds = YES;//very important
        self.badge.hidden = NO;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }
}

- (void)adjustLabelWidth:(UILabel *)label{
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}

#pragma mark -- animation
- (void)beginAnimation{
    switch(self.aniType) {
        case WBadgeAnimTypeBreathe:
            [self.badge.layer addAnimation:[CAAnimation opacityForever_Animation:1.4]
                                    forKey:kBadgeBreatheAniKey];
            break;
        case WBadgeAnimTypeShake:
            [self.badge.layer addAnimation:[CAAnimation shake_AnimationRepeatTimes:CGFLOAT_MAX
                                                                          durTimes:1
                                                                            forObj:self.badge.layer]
                                    forKey:kBadgeShakeAniKey];
            break;
        case WBadgeAnimTypeScale:
            [self.badge.layer addAnimation:[CAAnimation scaleFrom:1.4
                                                          toScale:0.6
                                                         durTimes:1
                                                              rep:MAXFLOAT]
                                    forKey:kBadgeScaleAniKey];
            break;
        case WBadgeAnimTypeBounce:
            [self.badge.layer addAnimation:[CAAnimation bounce_AnimationRepeatTimes:CGFLOAT_MAX
                                                                           durTimes:1
                                                                             forObj:self.badge.layer]
                                    forKey:kBadgeBounceAniKey];
            break;
        case WBadgeAnimTypeNone:
        default:
            break;
    }
}


- (void)removeAnimation{
    if (self.badge) {
        [self.badge.layer removeAllAnimations];
    }
}


#pragma mark -- setter/getter
- (UILabel *)badge{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadge:(UILabel *)label{
    objc_setAssociatedObject(self, @selector(badge), label, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)badgeFont{
    id font = objc_getAssociatedObject(self, _cmd);
    return font == nil ? kWZLBadgeDefaultFont : font;
}

- (void)setBadgeFont:(UIFont *)badgeFont{
    objc_setAssociatedObject(self, @selector(badgeFont), badgeFont, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.font = badgeFont;
}

- (UIColor *)badgeBgColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor{
    objc_setAssociatedObject(self, @selector(badgeBgColor), badgeBgColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.backgroundColor = badgeBgColor;
}

- (UIColor *)badgeTextColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor{
    objc_setAssociatedObject(self, @selector(badgeTextColor), badgeTextColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.textColor = badgeTextColor;
}

- (WBadgeAnimType)aniType{
    id obj = objc_getAssociatedObject(self, _cmd);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]]){
        return [obj integerValue];
    }
    return WBadgeAnimTypeNone;
}

- (void)setAniType:(WBadgeAnimType)aniType{
    NSNumber *numObj = @(aniType);
    objc_setAssociatedObject(self, @selector(aniType), numObj, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    [self removeAnimation];
    [self beginAnimation];
}

- (CGRect)badgeFrame{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 4) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        CGFloat width = [obj[@"width"] floatValue];
        CGFloat height = [obj[@"height"] floatValue];
        return  CGRectMake(x, y, width, height);
    }
    return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame{
    NSDictionary *frameInfo = @{@"x" : @(badgeFrame.origin.x), @"y" : @(badgeFrame.origin.y),
                                @"width" : @(badgeFrame.size.width), @"height" : @(badgeFrame.size.height)};
    objc_setAssociatedObject(self, @selector(badgeFrame), frameInfo, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.frame = badgeFrame;
}

- (CGPoint)badgeCenterOffset{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        return CGPointMake(x, y);
    }
    return CGPointZero;
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOff{
    NSDictionary *cenerInfo = @{@"x" : @(badgeCenterOff.x), @"y" : @(badgeCenterOff.y)};
    objc_setAssociatedObject(self, @selector(badgeCenterOffset), cenerInfo, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + badgeCenterOff.x, badgeCenterOff.y);
}

- (CGFloat)badgeRadius {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    objc_setAssociatedObject(self, @selector(badgeRadius), [NSNumber numberWithFloat:badgeRadius], OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
}

- (NSInteger)badgeMaximumBadgeNumber {
    id obj = objc_getAssociatedObject(self, _cmd);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]]){
        return [obj integerValue];
    }
    return kWZLBadgeDefaultMaximumBadgeNumber;
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber {
    NSNumber *numObj = @(badgeMaximumBadgeNumber);
    objc_setAssociatedObject(self, @selector(badgeMaximumBadgeNumber), numObj, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
}

@end
