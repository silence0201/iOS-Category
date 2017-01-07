//
//  NSObject+QuickCopy.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (QuickCopy)

/** 快速浅复制目标的所有属性 */
- (BOOL)quickCopy:(NSObject *)instance ;

/** 快速深复制目标的所有属性 */
- (BOOL)quickDeepCopy:(NSObject *)instance ;

@end
