//
//  NSArray+Block.m
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSArray+Block.h"

@implementation NSArray (Block)

- (void)eachWithBlock:(void (^)(id))block{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)eachWithBlockAndIndex:(void (^)(id, NSUInteger))block{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (NSArray *)mapWithBlock:(id (^)(id))block{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    for (id object in self) {
        [array addObject:block(object) ?: [NSNull null]];
    }
    return array;
}

- (NSArray *)filterWithBlock:(BOOL (^)(id))block{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray *)rejectWithBlock:(BOOL (^)(id))block{
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return !block(evaluatedObject);
    }]];
}

@end
