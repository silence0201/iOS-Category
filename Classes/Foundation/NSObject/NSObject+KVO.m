//
//  NSObject+KVO.m
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/runtime.h>

@implementation NSObject (KVO)

-(void)addObserver:(NSObject *)observer
        forKeyPath:(NSString *)keyPath
           options:(NSKeyValueObservingOptions)options
           context:(void *)context
         withBlock:(KVOBlock)block {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

-(void)removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    KVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    block(change, context);
}

-(void)addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(KVOBlock)block {
    
    [self addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

-(void)removeBlockObserverForKeyPath:(NSString *)keyPath {
    [self removeBlockObserver:self forKeyPath:keyPath];
}

@end
