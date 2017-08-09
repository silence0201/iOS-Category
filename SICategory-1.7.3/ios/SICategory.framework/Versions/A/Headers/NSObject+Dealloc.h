//
//  NSObject+Dealloc.h
//  Category
//
//  Created by 杨晴贺 on 2017/5/25.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DeallocBlock)();

@interface NSObject (Dealloc)

- (void)executeAtDealloc:(DeallocBlock)block;

@end
