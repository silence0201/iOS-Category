//
//  NSObject+Block.m
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+Block.h"

static inline dispatch_time_t dTimeDelay(NSTimeInterval time) {
    int64_t delta = (int64_t)(NSEC_PER_SEC * time);
    return dispatch_time(DISPATCH_TIME_NOW, delta);
}

@implementation NSObject (Block)

+ (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    if (!block) return nil;
    __block BOOL cancelled = NO;
    void (^wrappingBlock)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled)block();
    };
    wrappingBlock = [wrappingBlock copy];
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO); });
    return wrappingBlock;
}

+ (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay {
    if (!block) return nil;
    __block BOOL cancelled = NO;
    void (^wrappingBlock)(BOOL, id) = ^(BOOL cancel, id arg) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(arg);
    };
    wrappingBlock = [wrappingBlock copy];
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO, anObject); });
    return wrappingBlock;
}

- (id)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
    if (!block) return nil;
    __block BOOL cancelled = NO;
    void (^wrappingBlock)(BOOL) = ^(BOOL cancel) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block();
    };
    wrappingBlock = [wrappingBlock copy];
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO); });
    return wrappingBlock;
}

- (id)performBlock:(void (^)(id arg))block withObject:(id)anObject afterDelay:(NSTimeInterval)delay {
    if (!block) return nil;
    __block BOOL cancelled = NO;
    void (^wrappingBlock)(BOOL, id) = ^(BOOL cancel, id arg) {
        if (cancel) {
            cancelled = YES;
            return;
        }
        if (!cancelled) block(arg);
    };
    wrappingBlock = [wrappingBlock copy];
    dispatch_after(dTimeDelay(delay), dispatch_get_main_queue(), ^{  wrappingBlock(NO, anObject); });
    return wrappingBlock;
}

+ (void)cancelBlock:(id)block {
    if (!block) return;
    void (^aWrappingBlock)(BOOL) = (void(^)(BOOL))block;
    aWrappingBlock(YES);
}

@end
