//
//  SIPushNotificationManager.h
//  Category
//
//  Created by Silence on 2017/12/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "SIPushNotificationManager.h"
#import <CoreLocation/CoreLocation.h>

///-------------------------
#pragma mark - Utility
///-------------------------
#define IsAvailableString(_ref)   (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && ([_ref isKindOfClass:[NSString class]]) && (_ref.length > 0))

///-------------------------
#pragma mark - DEBUG
///-------------------------
#ifdef DEBUG
#define DLog(FORMAT, ...) fprintf(stderr, "%s [Line %zd]\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(FORMAT, ...) nil
#endif

static SIPushNotificationManager *_instance = nil;

@implementation SIPushNotificationManager

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+(id)copyWithZone:(nullable NSZone *)zone{
    return _instance;
}

#pragma mark 普通推送
-(void)normalPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 普通推送,可设置自定义提示音
-(void)normalPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                             soundName:(NSString *)soundName
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 图像推送,包含png、jpg、gif等图像格式
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                                fileName:(NSString *)fileName
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    NSArray *array = [fileName componentsSeparatedByString:@"."];
    NSString *graphicsPath = [[NSBundle mainBundle]pathForResource:array[0] ofType:array[1]];
    
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL fileURLWithPath:graphicsPath] options:nil error:nil];
    content.attachments = @[attachment];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 图像推送,包含png、jpg、gif等图像格式,可设置自定义提示音
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                                fileName:(NSString *)fileName
                               soundName:(NSString *)soundName
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSArray *array = [fileName componentsSeparatedByString:@"."];
    NSString *graphicsPath = [[NSBundle mainBundle]pathForResource:array[0] ofType:array[1]];
    
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL fileURLWithPath:graphicsPath] options:nil error:nil];
    content.attachments = @[attachment];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 图像推送,可以通过链接下载
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                               urlString:(NSString *)urlString
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    NSData *graphicsData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;

    NSString *localPath = [documentPath stringByAppendingPathComponent:@"PushNotificationGraphics.png"];
    [graphicsData writeToFile:localPath atomically:YES];
    
    if (localPath && ![localPath isEqualToString:@""]) {
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
        if (attachment) {
            content.attachments = @[attachment];
        }
    }
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 图像推送,可以通过链接下载,可设置自定义提示音
-(void)graphicsPushNotificationWithTitle:(NSString *)title
                                subTitle:(NSString *)subTitle
                                    body:(NSString *)body
                              identifier:(NSString *)identifier
                               urlString:(NSString *)urlString
                               soundName:(NSString *)soundName
                            timeInterval:(NSInteger)timeInterval
                                userInfo:(NSDictionary *)userInfo
                                  repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSData *graphicsData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [documentPath stringByAppendingPathComponent:@"PushNotificationGraphics.png"];
    [graphicsData writeToFile:localPath atomically:YES];
    
    if (localPath && ![localPath isEqualToString:@""]) {
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
        if (attachment) {
            content.attachments = @[attachment];
        }
    }
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 视频推送
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                             fileName:(NSString *)fileName
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    NSArray *array = [fileName componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:array[0] ofType:array[1]];
    
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL fileURLWithPath:filePath] options:nil error:nil];
    content.attachments = @[attachment];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 视频推送,可设置自定义提示音
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                             fileName:(NSString *)fileName
                            soundName:(NSString *)soundName
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSArray *array = [fileName componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:array[0] ofType:array[1]];

    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL fileURLWithPath:filePath] options:nil error:nil];
    content.attachments = @[attachment];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 视频推送,可以通过链接下载
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                            urlString:(NSString *)urlString
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    NSData *videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [documentPath stringByAppendingPathComponent:@"PushNotificationVideo.mp4"];
    [videoData writeToFile:localPath atomically:YES];
    
    if (localPath && ![localPath isEqualToString:@""]) {
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
        if (attachment) {
            content.attachments = @[attachment];
        }
    }
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 视频推送,可以通过链接下载,可设置自定义提示音
-(void)videoPushNotificationWithTitle:(NSString *)title
                             subTitle:(NSString *)subTitle
                                 body:(NSString *)body
                           identifier:(NSString *)identifier
                            urlString:(NSString *)urlString
                            soundName:(NSString *)soundName
                         timeInterval:(NSInteger)timeInterval
                             userInfo:(NSDictionary *)userInfo
                               repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSData *videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString *localPath = [documentPath stringByAppendingPathComponent:@"PushNotificationVideo.mp4"];
    [videoData writeToFile:localPath atomically:YES];
    
    if (localPath && ![localPath isEqualToString:@""]) {
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:[NSURL URLWithString:[@"file://" stringByAppendingString:localPath]] options:nil error:nil];
        if (attachment) {
            content.attachments = @[attachment];
        }
    }
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 定时推送
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                               weekday:(NSString *)weekday
                                  hour:(NSString *)hour
                                minute:(NSString *)minute
                                second:(NSString *)second
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    if (weekday && weekday != nil) {
        components.weekday = [weekday integerValue] + 1;
    }
    if (hour && hour != nil) {
        components.hour = [hour integerValue];
    }
    if (minute && minute != nil) {
        components.minute = [minute integerValue];
    }
    if (second && second != nil) {
        components.second = [second integerValue];
    }
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark - `push notification style of timing,provide a customized alert sound`->`定时推送,可设置自定义提示音`
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                               weekday:(NSString *)weekday
                                  hour:(NSString *)hour
                                minute:(NSString *)minute
                                second:(NSString *)second
                             soundName:(NSString *)soundName
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    if (weekday && weekday != nil) {
        components.weekday = [weekday integerValue] + 1;
    }
    if (hour && hour != nil) {
        components.hour = [hour integerValue];
    }
    if (minute && minute != nil) {
        components.minute = [minute integerValue];
    }
    if (second && second != nil) {
        components.second = [second integerValue];
    }
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 定时推送(行如2017-10-1)
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
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    if (year && year != nil) {
        components.year = [year integerValue];
    }
    if (month && month != nil) {
        components.month = [month integerValue];
    }
    if (hour && hour != nil) {
        components.hour = [hour integerValue];
    }
    if (minute && minute != nil) {
        components.minute = [minute integerValue];
    }
    if (second && second != nil) {
        components.second = [second integerValue];
    }
   
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:components];
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:date];
    components.weekday = weekday +1;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 定时推送,可设置自定义提示音(行如2017-10-1)
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
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    if (year && year != nil) {
        components.year = [year integerValue];
    }
    if (month && month != nil) {
        components.month = [month integerValue];
    }
    if (hour && hour != nil) {
        components.hour = [hour integerValue];
    }
    if (minute && minute != nil) {
        components.minute = [minute integerValue];
    }
    if (second && second != nil) {
        components.second = [second integerValue];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:components];
    NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:date];
    components.weekday = weekday +1;
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 定时推送,启动时间包含在字典内
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                              fireDate:(NSDictionary *)fireDate
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
  
    NSDateComponents *components = [[NSDateComponents alloc]init];
    if (fireDate[@"year"] && fireDate[@"year"] != nil) {
        components.year = [fireDate[@"year"] integerValue];
    }
    if (fireDate[@"month"] && fireDate[@"month"] != nil) {
        components.month = [fireDate[@"month"] integerValue];
    }
    if (fireDate[@"day"] && fireDate[@"day"] != nil) {
        components.day = [fireDate[@"day"] integerValue];
    }
    if (fireDate[@"hour"] && fireDate[@"hour"] != nil) {
        components.hour = [fireDate[@"hour"] integerValue];
    }
    if (fireDate[@"minute"] && fireDate[@"minute"] != nil) {
        components.minute = [fireDate[@"minute"] integerValue];
    }
    if (fireDate[@"second"] && fireDate[@"second"] != nil) {
        components.second = [fireDate[@"second"] integerValue];
    }
    if (fireDate[@"weekday"] && fireDate[@"weekday"] != nil) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *date = [calendar dateFromComponents:components];
        NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:date];
        components.weekday = weekday +1;
    }
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 定时推送,推送时间包含在字典内,可设置自定义提示音
-(void)timingPushNotificationWithTitle:(NSString *)title
                              subTitle:(NSString *)subTitle
                                  body:(NSString *)body
                            identifier:(NSString *)identifier
                              fireDate:(NSDictionary *)fireDate
                             soundName:(NSString *)soundName
                          timeInterval:(NSInteger)timeInterval
                              userInfo:(NSDictionary *)userInfo
                                repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    if (fireDate[@"year"] && fireDate[@"year"] != nil) {
        components.year = [fireDate[@"year"] integerValue];
    }
    if (fireDate[@"month"] && fireDate[@"month"] != nil) {
        components.month = [fireDate[@"month"] integerValue];
    }
    if (fireDate[@"day"] && fireDate[@"day"] != nil) {
        components.day = [fireDate[@"day"] integerValue];
    }
    if (fireDate[@"hour"] && fireDate[@"hour"] != nil) {
        components.hour = [fireDate[@"hour"] integerValue];
    }
    if (fireDate[@"minute"] && fireDate[@"minute"] != nil) {
        components.minute = [fireDate[@"minute"] integerValue];
    }
    if (fireDate[@"second"] && fireDate[@"second"] != nil) {
        components.second = [fireDate[@"second"] integerValue];
    }
    if (fireDate[@"weekday"] && fireDate[@"weekday"] != nil) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *date = [calendar dateFromComponents:components];
        NSInteger weekday = [calendar component:NSCalendarUnitWeekday fromDate:date];
        components.weekday = weekday +1;
    }
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 交互推送
-(void)interactivePushNotificationWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                 identifier:(NSString *)identifier
                            identifierArray:(NSArray<NSString *> *)identifierArray
                                actionArray:(NSArray<UNNotificationAction *> *)actionArray
                               timeInterval:(NSInteger)timeInterval
                                   userInfo:(NSDictionary *)userInfo
                                     repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:identifier actions:actionArray intentIdentifiers:identifierArray options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category, nil]];
    
    content.categoryIdentifier = identifier;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];

    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 交互推送,可设置自定义提示音
-(void)interactivePushNotificationWithTitle:(NSString *)title
                                   subTitle:(NSString *)subTitle
                                       body:(NSString *)body
                                 identifier:(NSString *)identifier
                            identifierArray:(NSArray<NSString *> *)identifierArray
                                actionArray:(NSArray<UNNotificationAction *> *)actionArray
                                  soundName:(NSString *)soundName
                               timeInterval:(NSInteger)timeInterval
                                   userInfo:(NSDictionary *)userInfo
                                     repeat:(BOOL)repeat
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:identifier actions:actionArray intentIdentifiers:identifierArray options:UNNotificationCategoryOptionCustomDismissAction];
    
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObjects:category, nil]];
    
    content.categoryIdentifier = identifier;
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:repeat];

    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark 定点推送
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
                                  repeat:(BOOL)repeat{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(longitude,latitude);
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:radius identifier:identifier];
    region.notifyOnEntry = notifyOnEntey;
    region.notifyOnExit = notifyOnExit;
    
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:repeat];

    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark @"intro.mp3"` ->`定点推送,可设置自定义提示音`
- (void)locationPushNotificationWithTitle:(NSString *)title
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
                                   repeat:(BOOL)repeat{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = subTitle;
    content.body = body;
    content.badge = @1;
    content.userInfo = userInfo;
    
    if (soundName) {
        content.sound = [UNNotificationSound soundNamed:soundName];
    }else{
        content.sound = [UNNotificationSound defaultSound];
    }
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(longitude,latitude);
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:radius identifier:identifier];
    region.notifyOnEntry = notifyOnEntry;
    region.notifyOnExit = notifyOnExit;
    
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:repeat];
    
    [self registerPushNotificationWithIdentifier:identifier content:content trigger:trigger];
}

#pragma mark - `Register Push Notification`->添加推送
- (void)registerPushNotificationWithIdentifier:(NSString *)identifier
                                       content:(UNMutableNotificationContent *)content
                                       trigger:(UNNotificationTrigger *)trigger{
    UNNotificationRequest *request;
    if ([trigger isKindOfClass:[UNCalendarNotificationTrigger class]]) {
        request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    }else if ([trigger isKindOfClass:[UNTimeIntervalNotificationTrigger class]]){
        request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    }else if ([trigger isKindOfClass:[UNLocationNotificationTrigger class]]){
        request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    }
    
    // `push notification` ->`发送推送`
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil) {
            DLog(@"the push notification identifier is: %@ \n and content is:  %@ \n with trigger: %@",request.identifier,content,trigger);
        }
    }];
}

@end
