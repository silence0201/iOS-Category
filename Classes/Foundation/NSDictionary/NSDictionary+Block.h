//
//  NSDictionary+Block.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Block)

- (void)eachWithBlock:(void (^)(id key, id value))block;
- (void)eachKeyWithBlock:(void (^)(id key))block;
- (void)eachValueWithBlock:(void (^)(id value))block;

- (NSArray *)mapWithBlock:(id (^)(id key, id value))block;

- (NSDictionary *)filterWithBlock:(BOOL (^)(id key))block ;
- (NSDictionary *)rejectWithBlock:(BOOL (^)(id key))block ;

@end
