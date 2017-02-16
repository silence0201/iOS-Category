//
//  SIShortcutsMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// Localized string helpers
#ifndef LOCALIZED_STRING
#define LOCALIZED_STRING(string)                NSLocalizedString(string, nil)
#else
#pragma message("LOCALIZED_STRING already declared")
#endif

#define LANG                                        LOCALIZED_STRING(@"globals.lang")
#define LANG_DISPLAY                                LOCALIZED_STRING(@"globals.langDisplay")

// Shared instance shortcuts
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

// Network
#define NETWORK_ACTIVITY                            [APPLICATION networkActivityIndicatorVisible]

// Color consts
#define CLEAR_COLOR                                 [UIColor clearColor]

// Application informations
#define APPLICATION_NAME                            [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APPLICATION_VERSION                         [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APPLICATION_BUILD_VERSION                   [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleVersion"]
#define APPLICATION_BUNDLE_ID                       [MAIN_BUNDLE objectForInfoDictionaryKey:@"CFBundleIdentifier"]
