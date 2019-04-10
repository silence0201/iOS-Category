//
//  SIConsoleManager.h
//  Category
//
//  Created by Silence on 2018/1/3.
//  Copyright © 2018年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 使用CNLog可以在程序内查看日志
#ifdef DEBUG
#define CNLog(frmt, ...)    LOG_OBJC_MAYBE(frmt, ##__VA_ARGS__)
#else
#define CNLog(frmt, ...)
#endif

#define LOG_OBJC_MAYBE(frmt, ...) \
LOG_MAYBE(__PRETTY_FUNCTION__, frmt, ## __VA_ARGS__)

#define LOG_MAYBE(fnct,frmt, ...)                       \
do { if(1 & 1) LOG_MACRO(fnct, frmt, ##__VA_ARGS__); } while(0)


#define LOG_MACRO(fnct, frmt, ...) \
[[SIConsoleManager sharedConsole] function : fnct                          \
line : __LINE__                                           \
format : (frmt), ## __VA_ARGS__]

@interface SIConsoleManager : NSObject

+ (instancetype)sharedConsole;

- (void)startPrintLog;

- (void)stopPringting;

- (void)function:(const char *)function
            line:(NSUInteger)line
          format:(NSString *)format, ... NS_FORMAT_FUNCTION(3,4);

@end
