//
//  SIShortcutsMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// 加载本地字符串
#ifndef LOCALIZED_STRING
#define LOCALIZED_STRING(string)                NSLocalizedString(string, nil)
#else
#pragma message("LOCALIZED_STRING already declared")
#endif

#define LANG                                        LOCALIZED_STRING(@"globals.lang")
#define LANG_DISPLAY                                LOCALIZED_STRING(@"globals.langDisplay")

// 单例对象
#define NOTIFICATION_CENTER                         [NSNotificationCenter defaultCenter]
#define FILE_MANAGER                                [NSFileManager defaultManager]
#define MAIN_BUNDLE                                 [NSBundle mainBundle]
#define MAIN_THREAD                                 [NSThread mainThread]
#define MAIN_SCREEN                                 [UIScreen mainScreen]
#define USER_DEFAULTS                               [NSUserDefaults standardUserDefaults]
#define APPLICATION                                 [UIApplication sharedApplication]
#define CURRENT_DEVICE                              [UIDevice currentDevice]
#define MAIN_RUN_LOOP                               [NSRunLoop mainRunLoop]
#define GENERAL_PASTEBOARD                          [UIPasteboard generalPasteboard]
#define KEY_WINDOW                                  [[UIApplication sharedApplication] keyWindow]

// 字体
#define FONT(size)                                  [UIFont systemFontOfSize:size]
#define BOLD_FONT(size)                             [UIFont boldSystemFontOfSize:size]

// 网络
#define NETWORK_ACTIVITY                            [APPLICATION networkActivityIndicatorVisible]

// 归档
#define OBJECT2DATA(object)   [NSKeyedArchiver archivedDataWithRootObject:object]
#define DATA2OBJECT(data)     [NSKeyedUnarchiver unarchiveObjectWithData:data]

// Application信息
#define APPLICATION_NAME                            [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APPLICATION_VERSION                         [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APPLICATION_BUILD_VERSION                   [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleVersion"]
#define APPLICATION_BUNDLE_ID                       [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleIdentifier"]

//设置屏幕亮度
#define DECVICE_BRIGHTNESS(brightness) [[UIScreen mainScreen] setBrightness:brightness];
//设置屏幕常亮
#define DECVICE_NORMALLYON(isNornallyOn)   [[UIApplication sharedApplication] setIdleTimerDisabled:isNornallyOn];

// USER_DEFAULTS
#define USER_DEFAULTS                               [NSUserDefaults standardUserDefaults]
#define USER_DEFAULTS_SET_OBJECT_FOR_KEY(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
#define USER_DEFAULTS_OBJECT_FOR_KEY(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
#define USER_DEFAULTS_REMOVE_OBJECT_FOR_KEY(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

