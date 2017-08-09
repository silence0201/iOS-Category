//
//  CAAnimation+EasingEquations.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, CAAnimationEasingFunction) {
    CAAnimationEasingFunctionLinear,
    
    CAAnimationEasingFunctionEaseInQuad,
    CAAnimationEasingFunctionEaseOutQuad,
    CAAnimationEasingFunctionEaseInOutQuad,
    
    CAAnimationEasingFunctionEaseInCubic,
    CAAnimationEasingFunctionEaseOutCubic,
    CAAnimationEasingFunctionEaseInOutCubic,
    
    CAAnimationEasingFunctionEaseInQuartic,
    CAAnimationEasingFunctionEaseOutQuartic,
    CAAnimationEasingFunctionEaseInOutQuartic,
    
    CAAnimationEasingFunctionEaseInQuintic,
    CAAnimationEasingFunctionEaseOutQuintic,
    CAAnimationEasingFunctionEaseInOutQuintic,
    
    CAAnimationEasingFunctionEaseInSine,
    CAAnimationEasingFunctionEaseOutSine,
    CAAnimationEasingFunctionEaseInOutSine,
    
    CAAnimationEasingFunctionEaseInExponential,
    CAAnimationEasingFunctionEaseOutExponential,
    CAAnimationEasingFunctionEaseInOutExponential,
    
    CAAnimationEasingFunctionEaseInCircular,
    CAAnimationEasingFunctionEaseOutCircular,
    CAAnimationEasingFunctionEaseInOutCircular,
    
    CAAnimationEasingFunctionEaseInElastic,
    CAAnimationEasingFunctionEaseOutElastic,
    CAAnimationEasingFunctionEaseInOutElastic,
    
    CAAnimationEasingFunctionEaseInBack,
    CAAnimationEasingFunctionEaseOutBack,
    CAAnimationEasingFunctionEaseInOutBack,
    
    CAAnimationEasingFunctionEaseInBounce,
    CAAnimationEasingFunctionEaseOutBounce,
    CAAnimationEasingFunctionEaseInOutBounce
};

@interface CAAnimation (EasingEquations)

+ (CAKeyframeAnimation*)transformAnimationWithDuration:(CGFloat)duration
                                                  from:(CATransform3D)startValue
                                                    to:(CATransform3D)endValue
                                        easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (void)addAnimationToLayer:(CALayer *)layer
                   duration:(CGFloat)duration
                  transform:(CATransform3D)transform
             easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (CAKeyframeAnimation*)animationWithKeyPath:(NSString *)keyPath
                                    duration:(CGFloat)duration
                                        from:(CGFloat)startValue
                                          to:(CGFloat)endValue
                              easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (void)addAnimationToLayer:(CALayer *)layer
                withKeyPath:(NSString *)keyPath
                   duration:(CGFloat)duration
                         to:(CGFloat)endValue
             easingFunction:(CAAnimationEasingFunction)easingFunction;

+ (void)addAnimationToLayer:(CALayer *)layer
                withKeyPath:(NSString *)keyPath
                   duration:(CGFloat)duration
                       from:(CGFloat)startValue
                         to:(CGFloat)endValue
             easingFunction:(CAAnimationEasingFunction)easingFunction;

@end
