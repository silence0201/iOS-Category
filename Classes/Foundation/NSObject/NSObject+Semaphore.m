//
//  NSObject+Semaphore.m
//  Category
//
//  Created by Silence on 2020/1/8.
//  Copyright © 2020年 silence. All rights reserved.
//

#import "NSObject+Semaphore.h"
#import <objc/runtime.h>

@implementation NSObject (Semaphore)

- (dispatch_semaphore_t)semaphoreWithKey:(void *)key {
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key);
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(1);
    }
    return semaphore;
}

- (dispatch_semaphore_t)semaphoreWithKey:(void *)key andValue:(long)value {
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key);
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(value);
    }
    return semaphore;
}

@end
