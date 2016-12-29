//
//  NSObject+GCD.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCD)

- (void)performOnMainThread:(void(^)(void))block wait:(BOOL)wait;
- (void)performAsynchronous:(void(^)(void))block;
- (void)performAfter:(NSTimeInterval)seconds block:(void(^)(void))block;

@end
