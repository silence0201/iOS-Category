//
//  CountDownManager.h
//  Category
//
//  Created by Silence on 2019/4/20.
//  Copyright © 2019年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DateComplete)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second);
typedef void(^PER_SECBlock)(void);

@interface CountDownManager : NSObject

/// 用NSDate日期倒计时
-(void)countDownWithStratDate:(NSDate *)startDate
                   finishDate:(NSDate *)finishDate
                completeBlock:(DateComplete)completeBlock;

/// 用时间戳倒计时
-(void)countDownWithStratTimeStamp:(long long)starTimeStamp
                   finishTimeStamp:(long long)finishTimeStamp
                     completeBlock:(DateComplete)completeBlock;

/// 每秒走一次，回调block
-(void)countDownWithPER_SECBlock:(PER_SECBlock)PER_SECBlock;
-(void)destoryTimer;
-(NSDate *)dateWithLongLong:(long long)longlongValue;

@end

NS_ASSUME_NONNULL_END
