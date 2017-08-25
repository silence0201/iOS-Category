//
//  NSObject+PerformSelector.m
//  Category
//
//  Created by Silence on 2017/8/23.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSObject+PerformSelector.h"

@implementation NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray*)objects{
    // 创建签名对象
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    // 判断传入的方法是否存在
    if (signature == nil) {
        // 传入的方法不存在 就抛异常
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"没有对应的方法" reason:info userInfo:nil];
        return nil;
    }
    
    // 创建NSInvocation对象
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 保存方法所属的对象
    invocation.target = self;
    invocation.selector = aSelector;
    // 设置参数
    NSInteger arguments = signature.numberOfArguments-2;
    // 遍历少的
    NSUInteger objectsCount = objects.count;
    NSInteger count = MIN(arguments, objectsCount);
    for (int i = 0; i<count; i++) {
        NSObject *obj = objects[i];
        // 处理参数是NULL类型的情况
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        [invocation setArgument:&obj atIndex:i+2];
    }
    // 调用NSinvocation对象
    [invocation invoke];
    // 获取返回值
    id res = nil;
    // 判断当前方法是否有返回值
    if (signature.methodReturnLength!=0) {
        // getReturnValue获取返回值
        [invocation getReturnValue:&res];
    }
    return res;
}


@end
