//
//  SIUtilsMacros.h
//  Category
//
//  Created by Silence on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// 打开URL
#define OPEN_URL(url)                                           [APPLICATION openURL:(url)]
#define OPEN_STRING_URL(url)                                    [APPLICATION openURL:[NSURL URLWithString:([url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]])]]
#define CALL_NUMBER(number)                                     [APPLICATION openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:[number stringByReplacingOccurrencesOfString:@" " withString:@""]]]]

// 文件路径
#define PATH_DOCUMENTS                                          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_LIBRARY                                            [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_PRIVATE_STORAGE                                    [[PATH_LIBRARY stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"PrivateStorage"]
#define PATH_FOR_RESOURCE(file, ext)                            (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext] : nil)
#define PATH_FOR_RESOURCE_IN_DIRECTORY(file, ext, directory)    (file ? [MAIN_BUNDLE pathForResource:(file) ofType:ext inDirectory:directory] : nil)
#define TEMPORARY_FILE_PATH                                     [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%f", [NSDate timeIntervalSinceReferenceDate]]]
#define REMOVE_ITEM_AT_PATH(path)                               [FILE_MANAGER removeItemAtPath:path error:nil]
#define FILE_EXISTS_AT_PATH(path)                               [FILE_MANAGER fileExistsAtPath:path]

// 加载Xib
#define LOAD_NIB_NAMED(nibName)                                 do{[MAIN_BUNDLE loadNibNamed:nibName owner:self options:nil];}while(0)

// 用户交互设置
#define ENABLE_USER_INTERACTIONS                                [APPLICATION endIgnoringInteractionEvents]
#define DISABLE_USER_INTERACTIONS                               [APPLICATION beginIgnoringInteractionEvents]

// 移除通知
#define NOTIFICATION_CENTER_REMOVE                              [NOTIFICATION_CENTER removeObserver:self]

//  nil to [NSNull null]
#define nilToNSNull(value)                                      (value ? value : [NSNull null])
#define NSNullToNil(value)                                      ((id)value == [NSNull null] ? nil : value)

// 设备语言
#define APPLICATION_LANGUAGES_KEY                               @"AppleLanguages"
#define OVERRIDE_APPLICATION_LANGUAGE(newLang)                  do {[USER_DEFAULTS setObject:[NSArray arrayWithObject:newLang] forKey:APPLICATION_LANGUAGES_KEY]; [USER_DEFAULTS synchronize];} while(0)
#define RESET_APPLICATION_LANGUAGE                              do {[USER_DEFAULTS removeObjectForKey:APPLICATION_LANGUAGES_KEY]; [USER_DEFAULTS synchronize];} while(0)

// 显示所有可用字体
#define DUMP_FONT_LIST()  do {\
NSArray *familyNames = [[UIFont familyNames] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]]];\
NSArray *fonts;\
NSLog(@"Listing all availables fonts : ");\
NSLog(@"-------------------------------");\
for (NSString *familyName in familyNames)\
{\
NSLog(@"%@", familyName);\
fonts = [[UIFont fontNamesForFamilyName:familyName] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]]];\
for (NSString *fontName in fonts)\
NSLog(@"\t\t%@", fontName);\
NSLog(@"\n");\
}\
NSLog(@"-------------------------------");\
}  while(0)

// 信号量
#define SemaphoreBegin \
static dispatch_semaphore_t semaphore; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
semaphore = dispatch_semaphore_create(1); \
}); \
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

#define SemaphoreEnd \
dispatch_semaphore_signal(semaphore);

// 类型判断
#define isKindOf(x, cls)                [(x) isKindOfClass:[cls class]]         // 判断实例类型(含父类)
#define isMemberOf(x, cls)              [(x) isMemberOfClass:[cls class]]       // 判断实例类型(不含父类)
