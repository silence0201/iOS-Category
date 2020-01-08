//
//  NSObject+Semaphore.h
//  Category
//
//  Created by Silence on 2020/1/8.
//  Copyright © 2020年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Semaphore)

- (dispatch_semaphore_t)semaphoreWithKey:(void*)key;

- (dispatch_semaphore_t)semaphoreWithKey:(void*)key andValue:(long)value;

@end

NS_ASSUME_NONNULL_END
