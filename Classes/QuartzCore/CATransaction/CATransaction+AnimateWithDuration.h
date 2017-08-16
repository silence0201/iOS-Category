//
//  CATransaction+AnimateWithDuration.h
//  Category
//
//  Created by Silence on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CATransaction (AnimateWithDuration)

/**
 *  @author Denys Telezhkin
 *
 *  @brief  CATransaction 动画执 block回调
 *
 *  @param duration   动画时间
 *  @param animations 动画块
 *  @param completion 动画结束回调
 */
+(void)animateWithDuration:(NSTimeInterval)duration
                animations:(nullable void (^)(void))animations
                completion:(nullable void (^)())completion;

@end
