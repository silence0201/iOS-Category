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

- (void)addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
          withBlock:(KVOBlock)block;

-(void)removeBlockObserver:(NSObject *)observer
                forKeyPath:(NSString *)keyPath;

-(void)addObserverForKeyPath:(NSString *)keyPath
                     options:(NSKeyValueObservingOptions)options
                     context:(void *)context
                   withBlock:(KVOBlock)block;

-(void)removeBlockObserverForKeyPath:(NSString *)keyPath;


@end
