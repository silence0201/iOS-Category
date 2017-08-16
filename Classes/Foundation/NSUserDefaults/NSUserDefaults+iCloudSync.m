//
//  NSUserDefaults+iCloudSync.m
//  Category
//
//  Created by Silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSUserDefaults+iCloudSync.h"

@implementation NSUserDefaults (iCloudSync)

-(void)setValue:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync)
        [[NSUbiquitousKeyValueStore defaultStore] setValue:value forKey:key];
    [self setValue:value forKey:key];
}

-(id)valueForKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync){
        id value = [[NSUbiquitousKeyValueStore defaultStore] valueForKey:key];
        [self setValue:value forKey:key];
        [self synchronize];
        return value;
    }
    return [self valueForKey:key];
}

- (void)removeValueForKey:(NSString *)key iCloudSync:(BOOL)sync{
    [self removeObjectForKey:key iCloudSync:sync];
}

-(void)setObject:(id)value forKey:(NSString *)defaultName iCloudSync:(BOOL)sync{
    if (sync)
        [[NSUbiquitousKeyValueStore defaultStore] setObject:value forKey:defaultName];
    [self setObject:value forKey:defaultName];
}

-(id)objectForKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync){
        id value = [[NSUbiquitousKeyValueStore defaultStore] objectForKey:key];
        [self setObject:value forKey:key];
        [self synchronize];
        return value;
    }
    
    return [self objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync){
        [[NSUbiquitousKeyValueStore defaultStore] removeObjectForKey:key];
    }
    return [self removeObjectForKey:key];
}

- (BOOL)synchronizeAlsoiCloudSync:(BOOL)sync{
    BOOL res = true;
    if (sync)
        res &= [self synchronize];
    res &= [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    return res;
}

@end
