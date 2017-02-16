//
//  NSObject+Runtime.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)


/**
 交换实例方法

 @param originalSel 原始的SEL
 @param newSel 新的SEL
 @return 是否交换成功
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;


/**
 交换类方法

 @param originalSel 原始的SEL
 @param newSel 新的SEL
 @return 是否交换成功
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

@end
