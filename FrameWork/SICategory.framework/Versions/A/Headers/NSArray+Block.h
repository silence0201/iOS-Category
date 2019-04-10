//
//  NSArray+Block.h
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Block)


/**
 Block枚举遍历

 @param block Block
 */
- (void)eachWithBlock:(void (^)(id object))block ;

/**
 Block带有Index的枚举遍历

 @param block Block
 */
- (void)eachWithBlockAndIndex:(void (^)(id object, NSUInteger index))block ;


/**
 Block对对象进行映射

 @param block 映射Block
 @return 映射后的数组
 */
- (NSArray *)mapWithBlock:(id (^)(id object))block;


/**
 Block对数组进行筛选

 @param block 筛选Block
 @return 返回筛选后的数组
 */
- (NSArray *)filterWithBlock:(BOOL (^)(id object))block ;

/**
 删除满足条件的对象

 @param block Block条件
 @return 返回处理后的数组
 */
- (NSArray *)rejectWithBlock:(BOOL (^)(id object))block ;

@end
