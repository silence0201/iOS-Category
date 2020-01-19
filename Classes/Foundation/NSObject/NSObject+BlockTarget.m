//
//  NSObject+Observer.m
//  Category
//
//  Created by Silence on 2020/1/19.
//  Copyright © 2020年 silence. All rights reserved.
//

#import "NSObject+BlockTarget.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark  -  私有实现KVO的真实target类,每一个target对应了一个keyPath和监听该keyPahth的所有block,当KVO方法调用时，需要回调所有的block
@interface BlockTarget:NSObject
//添加一个KVOBlock
- (void)addBlock:(void(^)(__weak id obj, id oldValue,id newValue))block;
- (void)addNotificationBlick:(void(^)(NSNotification*notification))block;
- (void)doNotification:(NSNotification*)notification;
@end
@implementation BlockTarget {
    NSMutableSet *_blockTargetSet;
    NSMutableSet *_notificationBlockSet;
}
-(instancetype)init {
    if (self = [super init]) {
        _blockTargetSet = [NSMutableSet new];
        _notificationBlockSet = [NSMutableSet new];
    }
    return self;
}
- (void)addBlock:(void (^)(__weak id, id oldValue, id newValue))block {
    [_blockTargetSet addObject:[block copy]];
}
- (void)addNotificationBlick:(void (^)(NSNotification *))block {
    [_notificationBlockSet addObject:[block copy]];
}
-(void)doNotification:(NSNotification *)notification {
    if (!_notificationBlockSet.count) return;
    [_notificationBlockSet enumerateObjectsUsingBlock:^(void(^block)(NSNotification*notification), BOOL * _Nonnull stop) {
        block(notification);
    }];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (!_blockTargetSet.count) return;
    BOOL proir = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    //只接受值改变的消息
    if(proir) return;
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind!=NSKeyValueChangeSetting) return;
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal==[NSNull null]) {
        oldVal = nil;
    }
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal ==[NSNull null]) {
        newVal = nil;
    }
    //执行该target下的所有block
    [_blockTargetSet enumerateObjectsUsingBlock:^(void(^block)(__weak id obj,id oldVal, id newVal), BOOL * _Nonnull stop) {
        block(object,oldVal,newVal);
    }];
}
@end
@implementation NSObject (BlockTarget)
//定义一个指针
static void *const KVOBlockKey =@"KVOBlockKey";
static void *const KVOSemaphoreKey = @"KVOSemaphoreKey";
- (void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull, id _Nonnull, id _Nonnull))block{
    if(!keyPath || !block) return;
    dispatch_semaphore_t kvoSemaphore = [self getSemaphoreWithKey:KVOSemaphoreKey];
    //一下保证此段代码只有一个线程进项访问并修改
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    //取出存有所有KVOtarget的字典
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, KVOBlockKey);
    if (!allTargets) {
        //没有则创建
        allTargets = [NSMutableDictionary new];
        //绑定在改对象中
        objc_setAssociatedObject(self, KVOBlockKey, allTargets,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    //获取对应的keyPath中所有的target
    BlockTarget *targetForKeyPath = [allTargets objectForKey:keyPath];
    if (!targetForKeyPath) {
        //没有则创建
        targetForKeyPath = [BlockTarget new];
        //保存
        allTargets[keyPath] = targetForKeyPath;
        //如果第一次，则注册对keyPath的KVO监听
        [self addObserver:targetForKeyPath forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    
    [targetForKeyPath addBlock:block];
    //对象第一次注册KVO的类进行dealloc方法调剂
    [self swizzleDealloc];
    dispatch_semaphore_signal(kvoSemaphore);
}
- (void)removeObserverBlockForKeyPath:(NSString *)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, KVOBlockKey);
    if(!allTargets) return;
    BlockTarget *target = allTargets[keyPath];
    if(!target) return;
    dispatch_semaphore_t kvoSemaphore = [self getSemaphoreWithKey:KVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [self removeObserver:target forKeyPath:keyPath];
    [allTargets removeObjectForKey:keyPath];
    dispatch_semaphore_signal(kvoSemaphore);
}
- (void)removeAllObserverBlocks {
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, KVOBlockKey);
    if (!allTargets) return;
    dispatch_semaphore_t kvoSemaphore = [self getSemaphoreWithKey:KVOSemaphoreKey];
    dispatch_semaphore_wait(kvoSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key,BlockTarget*target, BOOL * _Nonnull stop) {
        [self removeObserver:target forKeyPath:key];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(kvoSemaphore);
}
static void* const notificationBlockKey = @"notificationBlockKey";
static void* const notificationSemaphoreKey = @"notificationSemaphoreKey";
-(void)addNotificationForName:(NSString *)name block:(void (^)(NSNotification * _Nonnull))block
{
    if(!name||!block) return;
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:notificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self, notificationBlockKey);
    if (!allTargets) {
        allTargets = @{}.mutableCopy;
        objc_setAssociatedObject(self, notificationBlockKey, allTargets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    BlockTarget *target = [allTargets objectForKey:name];
    if (!target) {
        target = [BlockTarget new];
        allTargets[name] = target;
        [[NSNotificationCenter defaultCenter] addObserver:target selector:@selector(doNotification:) name:name object:nil];
    }
    [target addNotificationBlick:block];
    [self swizzleDealloc];
    dispatch_semaphore_signal(notificationSemaphore);
}
-(void)removeNotificationForName:(NSString *)name
{
    if(!name)return;
    NSMutableDictionary *allTargets =objc_getAssociatedObject(self, notificationBlockKey);
    if(!allTargets)return;
    BlockTarget *target = allTargets[name];
    if(!target)return;
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:notificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [[NSNotificationCenter defaultCenter]removeObserver:target];
    [allTargets removeObjectForKey:name];
    dispatch_semaphore_signal(notificationSemaphore);
}
-(void)removeAllNotification
{
    NSMutableDictionary *allTargets = objc_getAssociatedObject(self,notificationBlockKey);
    if(!allTargets)return;
    dispatch_semaphore_t notificationSemaphore = [self getSemaphoreWithKey:notificationSemaphoreKey];
    dispatch_semaphore_wait(notificationSemaphore, DISPATCH_TIME_FOREVER);
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, BlockTarget *target, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] removeAllNotification];
    }];
    [allTargets removeAllObjects];
    dispatch_semaphore_signal(notificationSemaphore);
}
-(void)postNotificationWithName:(NSString *)name userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter]postNotificationWithName:name userInfo:userInfo];
}
static void * deallocHasSwizzledKey = "deallocHasSwizzledKey";
-(void)swizzleDealloc
{
    //我们给每个类绑定上一值来判断dealloc方法是否被调剂过，如果调剂过了就无需再次调剂了
    BOOL swizzled = [objc_getAssociatedObject(self.class, deallocHasSwizzledKey) boolValue];
    //如果调剂过则直接返回
    if (swizzled) return;
    //开始调剂
    Class swizzleClass = self.class;
    @synchronized (swizzleClass) {
        //获取原有的dealloc方法
        SEL deallocSelector = sel_registerName("dealloc");
        //初始化一个函数指针用于保存原有的eealloc方法
        __block void(*originalDealloc)(__unsafe_unretained id,SEL) = NULL;
        //实现我们自己的dealloc方法，通过block的方式
        id newDealloc = ^(__unsafe_unretained id objSelf){
            //这里我们移除所有的KVO
            [objSelf removeAllObserverBlocks];
            //这里我们移除所有的通知
            [objSelf removeAllNotification];
            //根据原有的dealloc方法是否存在进行判断
            if (originalDealloc == NULL) {//如果不存在，说明本类没有实现dealloc方法，则需向父类发送dealloc消息（objc_msgSendSuper）
                //构造objc_msgSendSuper所需要的参数，.receiver为方法的实际调用者，即为类本身，.super_class指向其父类
                struct objc_super superInfo={
                    .receiver = objSelf,
                    .super_class  = class_getSuperclass(swizzleClass)
                };
                //构建objc_msgSendSuper 函数
                void(*msgSend)(struct objc_super*,SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                msgSend(&superInfo,deallocSelector);
            }else {
                //如果存在，表明该类实现了dealloc方法，则直接调用即可
                //调用原来的dealloc方法
                originalDealloc(objSelf,deallocSelector);
            }
        };
        //根据block构建新的dealloc实现IMP
        IMP newDeallocIMP =imp_implementationWithBlock(newDealloc);
        //尝试添加新的dealloc 方法，如果该类已经重写dealloc方法则不能添加，反之添加成功
        if(!class_addMethod(swizzleClass, deallocSelector, newDeallocIMP, "v@:"))
        {
            //如果没有添加成功则保存原有的dealloc方法，用于新的dealloc方法中
            Method deallocMethod = class_getInstanceMethod(swizzleClass, deallocSelector);
            originalDealloc = (void(*)(__unsafe_unretained id,SEL))method_getImplementation(deallocMethod);
            originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
        };
        //标记该类已经调剂过了
        objc_setAssociatedObject(self.class, deallocHasSwizzledKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(dispatch_semaphore_t)getSemaphoreWithKey:(void*)key {
    dispatch_semaphore_t semaphore = objc_getAssociatedObject(self, key);
    if (!semaphore) {
        semaphore = dispatch_semaphore_create(1);
    }
    return semaphore;
}

@end
