//
//  NSObject+GCD.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCD)


/**
 在Main线程进行执行

 @param block Block
 @param wait 等待的时间
 */
- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)wait;


/**
 异步执行

 @param block Block
 */
- (void)performAsynchronous:(void(^)(void))block;

/**
 延迟执行

 @param seconds 延迟的时间
 @param block Block
 */
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;

@end
