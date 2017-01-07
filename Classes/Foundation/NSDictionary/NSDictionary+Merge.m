//
//  NSDictionary+Merge.m
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSDictionary+Merge.h"

@implementation NSDictionary (Merge)

+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2{
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    NSMutableDictionary * resultTemp = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [resultTemp addEntriesFromDictionary:dict2];
    [resultTemp enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([dict1 objectForKey:key]){
            if ([obj isKindOfClass:[NSDictionary class]]){
                NSDictionary * newVal = [[dict1 objectForKey: key] dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }else{
                [result setObject: obj forKey: key];
            }
        }else if([dict2 objectForKey:key]){
            if ([obj isKindOfClass:[NSDictionary class]]){
                NSDictionary * newVal = [[dict2 objectForKey: key] dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }else{
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
}

- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict{
    return [[self class] dictionaryByMerging:self with: dict];
}

- (NSDictionary *)dictionaryByAddingEntriesFromDictionary:(NSDictionary *)dictionary{
    NSMutableDictionary *result = [self mutableCopy];
    [result addEntriesFromDictionary:dictionary];
    return result;
}

- (NSDictionary *)dictionaryByRemovingEntriesWithKeys:(NSSet *)keys{
    NSMutableDictionary *result = [self mutableCopy];
    [result removeObjectsForKeys:keys.allObjects];
    return result;
}

@end
