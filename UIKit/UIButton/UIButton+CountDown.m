//
//  UIButton+CountDown.m
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIButton+CountDown.h"

@implementation UIButton (CountDown)

- (void)startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)())finishBlock;{
    __block NSInteger timeOut = timeout;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeOut <= 0)
        { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (finishBlock)
                {
                    finishBlock();
                }
                self.userInteractionEnabled = YES;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (waitBlock)
                {
                    waitBlock(timeOut);
                }
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

@end
