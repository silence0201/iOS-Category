//
//  CAMediaTimingFunction+AdditionalEquations.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (AdditionalEquations)

///---------------------------------------------------------------------------------------
/// @name Circ Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInCirc;
+(CAMediaTimingFunction *)easeOutCirc;
+(CAMediaTimingFunction *)easeInOutCirc;

///---------------------------------------------------------------------------------------
/// @name Cubic Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInCubic;
+(CAMediaTimingFunction *)easeOutCubic;
+(CAMediaTimingFunction *)easeInOutCubic;

///---------------------------------------------------------------------------------------
/// @name Expo Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInExpo;
+(CAMediaTimingFunction *)easeOutExpo;
+(CAMediaTimingFunction *)easeInOutExpo;

///---------------------------------------------------------------------------------------
/// @name Quad Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInQuad;
+(CAMediaTimingFunction *)easeOutQuad;
+(CAMediaTimingFunction *)easeInOutQuad;

///---------------------------------------------------------------------------------------
/// @name Quart Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInQuart;
+(CAMediaTimingFunction *)easeOutQuart;
+(CAMediaTimingFunction *)easeInOutQuart;

///---------------------------------------------------------------------------------------
/// @name Quint Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInQuint;
+(CAMediaTimingFunction *)easeOutQuint;
+(CAMediaTimingFunction *)easeInOutQuint;

///---------------------------------------------------------------------------------------
/// @name Sine Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInSine;
+(CAMediaTimingFunction *)easeOutSine;
+(CAMediaTimingFunction *)easeInOutSine;

///---------------------------------------------------------------------------------------
/// @name Back Easing
///---------------------------------------------------------------------------------------

+(CAMediaTimingFunction *)easeInBack;
+(CAMediaTimingFunction *)easeOutBack;
+(CAMediaTimingFunction *)easeInOutBack;


@end
