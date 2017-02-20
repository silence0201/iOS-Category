//
//  SIKeyboardShortcutManager.h
//  KeyboardShortcutManagerDemo
//
//  Created by 杨晴贺 on 19/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KeyBoardAction)();

#if TARGET_OS_SIMULATOR

@interface SIKeyboardShortcutManager : NSObject

@property (nonatomic,assign,getter=isEnabled) BOOL enabled ; /// 是否开启,默认是开启


/**
 单例

 @return Manager单例
 */
+ (instancetype)sharedManager ;


/**
 注册快捷键对应的Action

 @param key 键字符串
 @param modifiers 控制键类型
 @param action 行为Action
 */
- (void)registerSimulatorShortcutWithKey:(NSString *)key
                               modifiers:(UIKeyModifierFlags)modifiers
                                  action:(KeyBoardAction)action;

@end
#endif
