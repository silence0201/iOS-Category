//
//  SIPushNotificationManager.h
//  Category
//
//  Created by Silence on 2017/12/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface SIPushNotificationManager : NSObject

+(instancetype)sharedInstance;

/// 申请权限
- (void)requestAuthorizationPushNotificationWithCompletion:(void (^)(BOOL))completion;

/// 普通推送
-(void)normalPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 普通推送,可设置自定义提示音
-(void)normalPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                             soundName:(NSString *)soundName
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 图像推送,包含png、jpg、gif等图像格式
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                                fileName:(NSString *)fileName
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat;

/// 图像推送,可设置自定义提示音
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                                fileName:(NSString *)fileName
                               soundName:(NSString *)soundName
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat;

/// 图像推送,可以通过链接下载
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                               urlString:(NSString *)urlString
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat;

/// 图像推送,可以通过链接下载,可设置自定义提示音
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                               urlString:(NSString *)urlString
                               soundName:(NSString *)soundName
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat;

/// 视频推送
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                             fileName:(NSString *)fileName
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat;

/// 视频推送,可设置自定义提示音
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                             fileName:(NSString *)fileName
                            soundName:(NSString *)soundName
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat;

/// 视频推送,可以通过链接下载
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                            urlString:(NSString *)urlString
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat;

/// 视频推送,可以通过链接下载,可设置自定义提示音
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                            urlString:(NSString *)urlString
                            soundName:(NSString *)soundName
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat;

/// 定时推送
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                               weekday:(NSString *)weekday
                                  hour:(NSString *)hour
                                minute:(NSString *)minute
                                second:(NSString *)second
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 定时推送,可设置自定义提示音
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                               weekday:(NSString *)weekday
                                  hour:(NSString *)hour
                                minute:(NSString *)minute
                                second:(NSString *)second
                             soundName:(NSString *)soundName
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 定时推送(行如2017-10-1 5:12)
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                                  year:(NSString *)year
                                 month:(NSString *)month
                                   day:(NSString *)day
                                  hour:(NSString *)hour
                                minute:(NSString *)minute
                                second:(NSString *)second
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 定时推送,可设置自定义提示音(行如2017-10-1 5:12)
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                                  year:(NSString *)year
                                 month:(NSString *)month
                                   day:(NSString *)day
                                  hour:(NSString *)hour
                                minute:(NSString *)minute
                                second:(NSString *)second
                             soundName:(NSString *)soundName
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

//    NSDictionary *dict = @{@"weekday":@1, //the `1` said Monday in China ->`1`等于中国周一,而不是美国周日
//                           @"hour":@2,
//                           @"minute":@20,
//                           @"second":@10
//                           }; // this meaning the fire date is "2:20:10 Monday" ->字典的内容表示中国时间"周一 2:20:10"
/// 定时推送,推送时间包含在字典内,字典使用方法如下
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                              fireDate:(NSDictionary *)fireDate
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 定时推送,推送时间包含在字典内,可设置自定义提示音
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                              fireDate:(NSDictionary *)fireDate
                             soundName:(NSString *)soundName
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat;

/// 交互推送
-(void)interactivePushNotificationWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                 identifier:(NSString *)identifier
                            identifierArray:(NSArray<NSString *> *)identifierArray
                                actionArray:(NSArray<UNNotificationAction *> *)actionArray
                               timeInterval:(NSInteger)timeInterval
                                   userInfo:(NSDictionary *)userInfo
                                     repeat:(BOOL)repeat;

/// 交互推送,可设置自定义提示音
-(void)interactivePushNotificationWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                 identifier:(NSString *)identifier
                            identifierArray:(NSArray<NSString *> *)identifierArray
                                actionArray:(NSArray<UNNotificationAction *> *)actionArray
                                  soundName:(NSString *)soundName
                               timeInterval:(NSInteger)timeInterval
                                   userInfo:(NSDictionary *)userInfo
                                     repeat:(BOOL)repeat;

/// 定点推送
-(void)locationPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                               longitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                                  radius:(NSInteger)radius
                           notifyOnEntry:(BOOL)notifyOnEntey
                            notifyOnExit:(BOOL)notifyOnExit
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat;

/// 定点推送,可设置自定义提示音
-(void)locationPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                               longitude:(CGFloat)longitude
                                latitude:(CGFloat)latitude
                                  radius:(NSInteger)radius
                           notifyOnEntry:(BOOL)notifyOnEntry
                            ontifyOnExit:(BOOL)notifyOnExit
                               soundName:(NSString *)soundName
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat;

@end
