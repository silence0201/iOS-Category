//
//  NSObject+KVO.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KVOBlock)(NSDictionary *change, void *context);
@interface NSObject (KVO)


/**
 添加KVO监听

 @param observer 对象
 @param keyPath keyPath
 @param options Option
 @param context Context
 @param block Action
 */
- (void)addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
          withBlock:(KVOBlock)block;


/**
 移除KVO监听

 @param observer 对象
 @param keyPath KeyPath
 */
-(void)removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath;


/**
 给self添加KVO监听

 @param keyPath KeyPath
 @param options Option
 @param context Context
 @param block Action
 */
-(void)addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(KVOBlock)block;


/**
 移除selfKVO监听

 @param keyPath KeyPath
 */
-(void)removeBlockObserverForKeyPath:(NSString *)keyPath;


@end
