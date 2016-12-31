//
//  NSArray+SafeAccess.m
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)randomObject{
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)objectWithIndex:(NSUInteger)index{
    if (index <self.count) {
        return self[index];
    }
    return nil;
}

- (NSString*)stringWithIndex:(NSUInteger)index
{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return @"";
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    return nil;
}


- (NSNumber*)numberWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
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

- (NSArray*)arrayWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]){
        return value;
    }
    return nil;
}


- (NSDictionary*)dictionaryWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]){
        return value;
    }
    return nil;
}

- (NSInteger)integerWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]){
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]){
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)boolWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
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
- (int16_t)int16WithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    return 0;
}
- (int32_t)int32WithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value intValue];
    }
    return 0;
}
- (int64_t)int64WithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value longLongValue];
    }
    return 0;
}

- (char)charWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value charValue];
    }
    return 0;
}

- (short)shortWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
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
- (float)floatWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value floatValue];
    }
    return 0;
}
- (double)doubleWithIndex:(NSUInteger)index{
    id value = [self objectWithIndex:index];
    if (value == nil || value == [NSNull null]){
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]){
        return [value doubleValue];
    }
    return 0;
}


@end

@implementation NSMutableArray (SafeAccess)

- (void)removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (id)popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self removeFirstObject];
    }
    return obj;
}

- (id)popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}


- (void)appendObject:(id)anObject {
    [self addObject:anObject];
}

- (void)prependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)appendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)prependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

-(void)appendString:(NSString*)i{
    if (i!=nil) {
        [self addObject:i];
    }
}
-(void)appendBool:(BOOL)i{
    [self addObject:@(i)];
}
-(void)appendInt:(int)i{
    [self addObject:@(i)];
}
-(void)appendInteger:(NSInteger)i{
    [self addObject:@(i)];
}
-(void)appendUnsignedInteger:(NSUInteger)i{
    [self addObject:@(i)];
}
-(void)appendChar:(char)c{
    [self addObject:@(c)];
}
-(void)appendFloat:(float)i{
    [self addObject:@(i)];
}

- (void)reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}


@end
