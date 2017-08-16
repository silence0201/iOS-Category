//
//  NSObject+GCD.m
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+GCD.h"

@implementation NSObject (GCD)

- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)shouldWait {
    if (shouldWait) {
        // 同步
        dispatch_sync(dispatch_get_main_queue(), block);
    }else {
        // 异步
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
- (void)performAsynchronous:(void(^)(void))block {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

@end
