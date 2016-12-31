//
//  NSArray+Block.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Block)

- (void)eachWithBlock:(void (^)(id object))block ;
- (void)eachWithBlockAndIndex:(void (^)(id object, NSUInteger index))block ;

- (NSArray *)mapWithBlock:(id (^)(id object))block;

- (NSArray *)filterWithBlock:(BOOL (^)(id object))block ;
- (NSArray *)rejectWithBlock:(BOOL (^)(id object))block ;

@end
