//
//  KKLog.h
//  Category
//  https://github.com/Coneboy-k/KKLog
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

/*
    1.程序Crash后的处理函数
 
    void uncaughtExceptionHandler(NSException *exception)
    {
        [KKLog logCrash:exception];
    }
    
    2. 初始化设置
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

        // 注册程序 Crash后的处理函数
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
 
        // KKLog 初始化函数
        [KKLog logIntial];
 
        // 设置logLevel
        [KKLog setLogLevel:LOGLEVELD];

    3. 使用日志方法

    [KKLog logI:@"info"];
    [KKLog logE:@"error"];
    [KKLog logW:@"worring"];...

    KKLogI(@"info");
    KKLogD(@"DDDD");...
*/

#import <Foundation/Foundation.h>

// Debug
#define KKLogD(desStr) [KKLog logD:[NSString stringWithFormat:@"Function:%s Line:%d Des:%@",__func__,__LINE__,desStr],@""];
// Info
#define KKLogI(desStr) [KKLog logI:[NSString stringWithFormat:@"Function:%s Line:%d Des:%@",__func__,__LINE__,desStr],@""];
// Warning
#define KKLogW(desStr) [KKLog logW:[NSString stringWithFormat:@"Function:%s Line:%d Des:%@",__func__,__LINE__,desStr],@""];
// Error
#define KKLogE(desStr) [KKLog logE:[NSString stringWithFormat:@"Function:%s Line:%d Des:%@",__func__,__LINE__,desStr],@""];



//日志等级
typedef enum
{
    LOGLEVELV = 0,  //wend
    LOGLEVELD = 1,  //Debug
    LOGLEVELI = 2,  //Info
    LOGLEVELW = 3,  //Warning
    LOGLEVELE = 4,  //Error
} KKLogLevel;

@interface KKLog : NSObject

/// log初始化函数，在系统启动时调用
+ (void)logIntial;

/// 设置要记录的log级别
+ (void)setLogLevel:(KKLogLevel)level;

/// 记录系统crash的Log函数
+ (void)logCrash:(NSException*)exception;

/// log记录函数
+ (void)logLevel:(KKLogLevel)level LogInfo:(NSString*)format,... NS_FORMAT_FUNCTION(2,3);

/// LOGLEVELV级Log记录函数
+ (void)logV:(NSString*)format,... NS_FORMAT_FUNCTION(1,2);

/// LOGLEVELD级Log记录函数
+ (void)logD:(NSString*)format,... NS_FORMAT_FUNCTION(1,2);

/// LOGLEVELI级Log记录函数
+ (void)logI:(NSString*)format,... NS_FORMAT_FUNCTION(1,2);

/// LOGLEVELW级Log记录函数
+ (void)logW:(NSString*)format,... NS_FORMAT_FUNCTION(1,2);

/// LOGLEVELE级Log记录函数
+ (void)logE:(NSString*)format,... NS_FORMAT_FUNCTION(1,2);

@end
