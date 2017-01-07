//
//  NSNotificationCenter+AutoRemove.m
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "NSNotificationCenter+AutoRemove.h"
#import <pthread.h>
#import <objc/runtime.h>


typedef void (^DeallocTaskBlock)(__unsafe_unretained id object, NSUInteger identifier);
static char DeallocTaskModelKey;
static BOOL NotificationGuardEnable = NO;
static char NotificationGuardDeallocTaskIdentifierKey;
static NSUInteger IdentifierIncrement = 0;
static pthread_mutex_t DeallocTaskIdentifierLock;
NSUInteger DeallocTaskIllegalIdentifier = 0;

@interface _DeallocTaskModel : NSObject {
    pthread_mutex_t _lock;
    CFMutableDictionaryRef _tasksDict;
}
@property (nonatomic, unsafe_unretained) id target;
@end

@implementation _DeallocTaskModel

- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        _target = target;
        pthread_mutex_init(&_lock, NULL);
        _tasksDict = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

- (NSUInteger)addTask:(DeallocTaskBlock)taskBlock {
    if (!taskBlock) {
        return DeallocTaskIllegalIdentifier;
    }
    pthread_mutex_lock(&DeallocTaskIdentifierLock);
    NSNumber *newIdentifier = [NSNumber numberWithUnsignedInteger:++IdentifierIncrement];
    pthread_mutex_unlock(&DeallocTaskIdentifierLock);
    if (newIdentifier) {
        pthread_mutex_lock(&_lock);
        CFDictionarySetValue(_tasksDict, (__bridge const void*)newIdentifier, (__bridge const void*)[taskBlock copy]);
        pthread_mutex_unlock(&_lock);
        return IdentifierIncrement;
    } else {
        return DeallocTaskIllegalIdentifier;
    }
}

- (BOOL)removeTaskWithIdentifier:(NSUInteger)identifier {
    if (identifier == DeallocTaskIllegalIdentifier) {
        return NO;
    }
    NSNumber *identifierNumber = [NSNumber numberWithUnsignedInteger:identifier];
    if (identifierNumber) {
        pthread_mutex_lock(&_lock);
        CFDictionaryRemoveValue(_tasksDict, (__bridge const void*)identifierNumber);
        pthread_mutex_unlock(&_lock);
        return YES;
    } else {
        return NO;
    }
}

- (void)removeAllTask {
    CFDictionaryRemoveAllValues(_tasksDict);
}

- (void)dealloc {
    [(__bridge NSDictionary *)_tasksDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull identifier, DeallocTaskBlock _Nonnull block, BOOL * _Nonnull stop) {
        block(_target, identifier.unsignedIntegerValue);
    }];
    pthread_mutex_destroy(&_lock);
    CFRelease(_tasksDict);
}
@end


@interface NSObject (DeallocTaskHelper)

@end

@implementation NSObject (TTGDeallocTaskHelper)

+ (void)load {
    pthread_mutex_init(&DeallocTaskIdentifierLock, NULL);
}

- (NSUInteger)_addDeallocTask:(DeallocTaskBlock)taskBlock {
    if (!taskBlock) {
        return DeallocTaskIllegalIdentifier;
    }
    _DeallocTaskModel *model = nil;
    @synchronized (self) {
        model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
        if (!model) {
            model = [[_DeallocTaskModel alloc] initWithTarget:self];
            objc_setAssociatedObject(self, &DeallocTaskModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    NSUInteger newIdentifier = [model addTask:taskBlock];
    return newIdentifier;
}

- (BOOL)_removeDeallocTaskByIdentifier:(NSUInteger)identifier {
    _DeallocTaskModel *model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
    if (model) {
        return [model removeTaskWithIdentifier:identifier];
    } else {
        return NO;
    }
}

- (void)_removeAllDeallocTasks {
    _DeallocTaskModel *model = objc_getAssociatedObject(self, &DeallocTaskModelKey);
    if (model) {
        [model removeAllTask];
    }
}

@end


@implementation NSNotificationCenter (AutoRemove)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.class __methodSwizzlingWithClass:[self class]
                                 originalSelector:@selector(addObserver:selector:name:object:)
                                 swizzledSelector:@selector(_addObserver:selector:name:object:)];
        
        [self.class __methodSwizzlingWithClass:[self class]
                                 originalSelector:@selector(removeObserver:)
                                 swizzledSelector:@selector(_removeObserver:)];
        
        [self.class __methodSwizzlingWithClass:[self class]
                                 originalSelector:@selector(addObserverForName:object:queue:usingBlock:)
                                 swizzledSelector:@selector(_addObserverForName:object:queue:usingBlock:)];
    });
}

#pragma mark - Public methods

+ (void)setNotificationAutoRemoveEnable:(BOOL)enable {
    NotificationGuardEnable = enable;
}

+ (BOOL)notificationAutoRemoveEnable {
    return NotificationGuardEnable;
}

#pragma mark - Swizzling methods

- (void)_addObserver:(id)observer selector:(SEL)sel name:(NSString *)notificationName object:(id)sender {
    [self _addObserver:observer selector:sel name:notificationName object:sender];
    [self.class __setAutoRemoveTaskForObserver:observer];
}

- (id<NSObject>)_addObserverForName:(NSString *)name
                             object:(id)obj
                              queue:(NSOperationQueue *)queue
                         usingBlock:(void (^)(NSNotification *note))block {
    id observer = [self _addObserverForName:name object:obj queue:queue usingBlock:block];
    [self.class __setAutoRemoveTaskForObserver:observer];
    return observer;
}

- (void)_removeObserver:(id)observer {
    [self.class __removeAutoRemoveTaskForObserver:observer];
    [self _removeObserver:observer];
}

#pragma mark - Other methods
+ (void)__setAutoRemoveTaskForObserver:(id)observer {
    if (!NotificationGuardEnable) {
        return;
    }
    NSUInteger identifier = [self __getDeallocTaskIdentifierFromObserver:observer];
    if (identifier == DeallocTaskIllegalIdentifier) {
        identifier = [observer _addDeallocTask:^(__unsafe_unretained id object, NSUInteger identifier) {
            [[NSNotificationCenter defaultCenter] removeObserver:object];
        }];
        [self __setDeallocTaskIdentifierToObserver:observer identifier:identifier];
    }
}

+ (void)__removeAutoRemoveTaskForObserver:(id)observer {
    NSUInteger identifier = [self __getDeallocTaskIdentifierFromObserver:observer];
    if (identifier != DeallocTaskIllegalIdentifier) {
        [observer _removeDeallocTaskByIdentifier:identifier];
    }
}

+ (NSUInteger)__getDeallocTaskIdentifierFromObserver:(id)observer {
    NSNumber *identifierNumber = objc_getAssociatedObject(observer, &NotificationGuardDeallocTaskIdentifierKey);
    if (identifierNumber && [identifierNumber isKindOfClass:[NSNumber class]] && identifierNumber.unsignedIntegerValue != DeallocTaskIllegalIdentifier) {
        return identifierNumber.unsignedIntegerValue;
    } else {
        return DeallocTaskIllegalIdentifier;
    }
}

+ (void)__setDeallocTaskIdentifierToObserver:(id)observer identifier:(NSUInteger)identifier {
    NSNumber *identifierNumber = [NSNumber numberWithUnsignedInteger:identifier];
    if (identifierNumber) {
        objc_setAssociatedObject(observer, &NotificationGuardDeallocTaskIdentifierKey, identifierNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (void)__methodSwizzlingWithClass:(Class) class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    if (!class || !originalSelector || !swizzledSelector) {
        return;
    }
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
