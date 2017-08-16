//
//  NSNotificationCenter+Thread.h
//  Category
//
//  Created by Silence on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (Thread)

/// 给主线程发送一个通知
- (void)postNotificationOnMainThread:(NSNotification *)notification;

/// 给主线程发送一个通知  wait是否立刻执行,NO表示立刻执行
- (void)postNotificationOnMainThread:(NSNotification *)notification
                       waitUntilDone:(BOOL)wait;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object;
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo;
- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;
@end
