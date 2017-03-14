//
//  NSTimer+Pause.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSTimer+Pause.h"

@implementation NSTimer (Pause)

-(void)pauseTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

-(void)resumeTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
