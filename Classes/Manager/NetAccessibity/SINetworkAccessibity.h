//
//  SINetworkAccessibity.h
//  Category
//
//  Created by Silence on 2019/4/24.
//  Copyright © 2019年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const SINetworkAccessibityChangedNotification;

typedef NS_ENUM(NSUInteger, SINetworkAccessibleState) {
    SINetworkChecking  = 0,
    SINetworkUnknown     ,
    SINetworkAccessible  ,
    SINetworkRestricted  ,
};

typedef void (^NetworkAccessibleStateNotifier)(SINetworkAccessibleState state);

@interface SINetworkAccessibity : NSObject

/**
 开启 NetworkAccessibity
 */
+ (void)start;

/**
 停止 NetworkAccessibity
 */
+ (void)stop;

/**
 当判断网络状态为 NetworkRestricted 时，提示用户开启网络权限
 */
+ (void)setAlertEnable:(BOOL)setAlertEnable;

/**
 通过 block 方式监控网络权限变化。
 */
+ (void)setStateDidUpdateNotifier:(NetworkAccessibleStateNotifier)block;

/**
 返回的是最近一次的网络状态检查结果，若距离上一次检测结果短时间内网络授权状态发生变化，该值可能会不准确。
 */
+ (SINetworkAccessibleState)currentState;

@end

NS_ASSUME_NONNULL_END
