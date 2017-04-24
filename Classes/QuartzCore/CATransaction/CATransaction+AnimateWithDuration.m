//
//  CATransaction+AnimateWithDuration.m
//  Category
//
//  Created by 杨晴贺 on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "CATransaction+AnimateWithDuration.h"

@implementation CATransaction (AnimateWithDuration)

+(void)animateWithDuration:(NSTimeInterval)duration
                animations:(void (^)(void))animations
                completion:(void (^)())completion{
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    if (completion){
        [CATransaction setCompletionBlock:completion];
    }
    if (animations){
        animations();
    }
    [CATransaction commit];
}

@end
