//
//  NSObject+Observer.h
//  Category
//
//  Created by Silence on 2020/1/19.
//  Copyright © 2020年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BlockTarget)
- (void)addObserverBlockForKeyPath:(NSString*)keyPath block:(void(^)(id obj,id oldVal,id newVal))block;
- (void)removeObserverBlockForKeyPath:(NSString*)keyPath;
- (void)removeAllObserverBlocks;

- (void)addNotificationForName:(NSString*)name  block:(void(^)(NSNotification*notification))block;
- (void)removeNotificationForName:(NSString*)name;
- (void)removeAllNotification;
- (void)postNotificationWithName:(NSString*)name userInfo:(nullable NSDictionary*)userInfo;
@end

NS_ASSUME_NONNULL_END
