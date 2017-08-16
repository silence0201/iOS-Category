//
//  NSObject+Parse.m
//  Category
//
//  Created by Silence on 19/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "NSObject+Parse.h"


static inline NSNumber *NumberFromString(NSString *string) {
    static NSNumberFormatter *f = nil;
    if (f == nil) {
        f = [[NSNumberFormatter alloc] init];
        [f setDecimalSeparator:@"."];
    }
    NSNumber *number = [f numberFromString:string];
    return number;
}

static inline NSArray *CastArrayUsingSelector(NSArray *array, SEL castSelector) {
    NSMutableArray *castedArray = [NSMutableArray arrayWithCapacity:[array count]];
    for (id object in array) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id castedObject = [object performSelector:castSelector];
#pragma clang diagnostic pop
        if (castedObject) {
            [castedArray addObject:castedObject];
        }
        else {
            return nil;
        }
    }
    return [castedArray copy];
}


@implementation NSObject (Parse)

+ (void)reportCastErrorFromClass:(Class)fromClass toClass:(Class)toClass{
    NSLog(@"%@: cannot cast object from class %@ to class %@",
          NSStringFromClass([self class]),
          NSStringFromClass(fromClass),
          NSStringFromClass(toClass));
}

- (NSString *)toString{
    [[self class] reportCastErrorFromClass:[self class] toClass:[NSString class]];
    return nil;
}

- (NSNumber *)toNumber{
    [[self class] reportCastErrorFromClass:[self class] toClass:[NSNumber class]];
    return nil;
}

- (NSDictionary *)toDictionary{
    [[self class] reportCastErrorFromClass:[self class] toClass:[NSDictionary class]];
    return nil;
}

- (NSArray *)toArray{
    [[self class] reportCastErrorFromClass:[self class] toClass:[NSArray class]];
    return nil;
}

- (NSArray *)toArrayOf:(Class)itemClass{
    [[self class] reportCastErrorFromClass:[self class] toClass:[NSArray class]];
    return nil;
}

- (NSObject *)safeCastToClass:(Class)toClass{
    if ([self isKindOfClass:toClass]) {
        return self;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    [[self class] reportCastErrorFromClass:[self class] toClass:toClass];
    return nil;
}

@end

@implementation NSNull (_Parse)

- (NSString *)toString{
    return nil;
}

- (NSNumber *)toNumber{
    return nil;
}

- (NSDictionary *)toDictionary{
    return nil;
}

- (NSArray *)toArray{
    return nil;
}

- (NSArray *)toArrayOf:(Class)itemClass{
    return nil;
}

@end


@implementation NSArray (_Parse)

- (NSArray *)toArray{
    return self;
}

static inline SEL CastSelectorForClass(Class class) {
    SEL castSelector = nil;
    if (class == [NSString class]) {
        castSelector = @selector(toString);
    }
    else if (class == [NSNumber class]) {
        castSelector = @selector(toNumber);
    }
    else if (class == [NSDictionary class]) {
        castSelector = @selector(toDictionary);
    }
    return castSelector;
}


static inline BOOL CheckArrayIsOfClass(NSArray *array, Class class) {
    for (id obj in array) {
        if ([obj safeCastToClass:class] == nil) {
            return NO;
        }
    }
    return YES;
}


- (NSArray *)toArrayOf:(Class)itemClass{
    SEL castSelector = CastSelectorForClass(itemClass);
    if (castSelector) {
        return CastArrayUsingSelector(self, castSelector);
    }
    else {
        return CheckArrayIsOfClass(self, itemClass) ? self : nil;
    }
}

- (NSString *)toString{
    NSArray *arrayOfString = [self toArrayOf:[NSString class]];
    if (arrayOfString) {
        return [arrayOfString componentsJoinedByString:@"\n"];
    }
    return nil;
}

@end


@implementation NSDictionary (_Parse)

- (NSDictionary *)toDictionary{
    return self;
}

- (NSArray *)toArrayOf:(Class)itemClass{
    if (itemClass == [NSDictionary class]) {
        return [self toArray];
    }
    return nil;
}

- (NSArray *)toArray{
    return @[ self ];
}

@end


@implementation NSString (_Parse)

- (NSString *)toString{
    return self;
}

- (NSNumber *)toNumber{
    return NumberFromString(self);
}

- (NSArray *)toArray{
    return @[ self ];
}

- (NSArray *)toArrayOf:(Class)itemClass{
    SEL castSelector = CastSelectorForClass(itemClass);
    if (castSelector == NULL) {
        return nil;
    }
    
    return CastArrayUsingSelector([self toArray], castSelector);
}

@end


@implementation NSNumber (_Parse)

- (NSString *)mr_toString{
    return [self stringValue];
}

- (NSNumber *)toNumber{
    return self;
}

- (NSArray *)toArray{
    return @[ self ];
}

- (NSArray *)toArrayOf:(Class)itemClass{
    SEL castSelector = CastSelectorForClass(itemClass);
    if (castSelector == NULL) {
        return nil;
    }
    return CastArrayUsingSelector([self toArray], castSelector);
}

@end
