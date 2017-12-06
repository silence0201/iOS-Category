//
//  SIMediatorManager.m
//  Category
//
//  Created by Silence on 23/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SIMediatorManager.h"
#import <objc/runtime.h>

@interface SIMediatorManager ()

@property (nonatomic,strong) NSMutableDictionary *cachedTarget ;

@end

@implementation SIMediatorManager

#pragma mark --- Public Method
+ (instancetype)sharedManager{
    static SIMediatorManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SIMediatorManager alloc] init];
    });
    return manager;
}

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        return @(NO);
    }
    id result = [self performTarget:url.host action:actionName params:params shouldCacheTarget:NO];
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}

- (id)performTarget:(NSString *)targetClassName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget{
    Class targetClass;
    NSObject *target = self.cachedTarget[targetClassName];
    if (target == nil) {
        targetClass = NSClassFromString(targetClassName);
        target = [[targetClass alloc] init];
    }
    
    SEL action = NSSelectorFromString(actionName);
    
    if (target == nil) {
        return nil;
    }
    
    if (shouldCacheTarget) {
        self.cachedTarget[targetClassName] = target;
    }
    
    if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
    } else {
        action = NSSelectorFromString(actionName);
        if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        } else {
            SEL action = NSSelectorFromString(@"notFound:");
            if ([target respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
            } else {
                [self.cachedTarget removeObjectForKey:targetClassName];
                return nil;
            }
        }
    }
}

- (void)releaseCachedTargetWithTargetName:(NSString *)targetName{
    [self.cachedTarget removeObjectForKey:targetName];
}

#pragma mark - getters and setters
- (NSMutableDictionary *)cachedTarget{
    if (_cachedTarget == nil) {
        _cachedTarget = [[NSMutableDictionary alloc] init];
    }
    return _cachedTarget;
}

@end
