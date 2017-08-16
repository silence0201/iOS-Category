//
//  NSDictionary+SafeAccess.m
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSDictionary+SafeAccess.h"

@implementation NSDictionary (SafeAccess)

- (NSString*)stringForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}

- (NSNumber*)numberForKey:(id)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSArray*)arrayForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]){
        return value;
    }
    return nil;
}

- (NSDictionary*)dictionaryForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]){
        return value;
    }
    return nil;
}

- (NSInteger)integerForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]){
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)unsignedIntegerForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]){
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)boolForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]){
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]){
        return [value boolValue];
    }
    return NO;
}
- (int16_t)int16ForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]){
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]){
        return [value intValue];
    }
    return 0;
}
- (int32_t)int32ForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value intValue];
    }
    return 0;
}
- (int64_t)int64ForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value longLongValue];
    }
    return 0;
}
- (char)charForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value charValue];
    }
    return 0;
}
- (short)shortForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]]){
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]]){
        return [value intValue];
    }
    return 0;
}
- (float)floatForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value floatValue];
    }
    return 0;
}
- (double)doubleForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value doubleValue];
    }
    return 0;
}
- (long long)longLongForKey:(id)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    return 0;
}

- (unsigned long long)unsignedLongLongForKey:(id)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    return 0;
}

@end

@implementation NSMutableDictionary (SafeAccess)

-(void)setObj:(id)i forKey:(NSString*)key{
    if (i) {
        self[key] = i;
    }
}
-(void)setString:(NSString*)i forKey:(NSString*)key;{
    [self setValue:i forKey:key];
}
-(void)setBool:(BOOL)i forKey:(NSString *)key{
    [self setObj:@(i) forKey:key] ;
}
-(void)setInt:(int)i forKey:(NSString *)key{
    [self setObj:@(i) forKey:key] ;
}
-(void)setInteger:(NSInteger)i forKey:(NSString *)key{
    [self setObj:@(i) forKey:key] ;
}
-(void)setUnsignedInteger:(NSUInteger)i forKey:(NSString *)key{
    [self setObj:@(i) forKey:key] ;
}
-(void)setChar:(char)c forKey:(NSString *)key{
    [self setObj:@(c) forKey:key] ;
}
-(void)setFloat:(float)i forKey:(NSString *)key{
    [self setObj:@(i) forKey:key] ;
}
-(void)setDouble:(double)i forKey:(NSString*)key{
    [self setObj:@(i) forKey:key] ;
}
-(void)setLongLong:(long long)i forKey:(NSString*)key{
    [self setObj:@(i) forKey:key] ;
}


@end
