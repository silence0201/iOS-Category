//
//  LogUnicode.m
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@implementation NSObject (_ChangeSEL)

/// 交换两个SEL指向的方法的指针
+ (void)exchangeSelector:(SEL)oldSel andNewSelector:(SEL)newSel {
    Class cls = [self class];
    Method oldMethod = class_getInstanceMethod(cls, oldSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    method_exchangeImplementations(oldMethod, newMethod);
}

@end

@implementation NSDictionary (_UnicodeTransfer)

+ (void)load {
    // 类加载的时候会调用的
    // 此处与自己写的方法指针
    [self exchangeSelector:@selector(descriptionWithLocale:) andNewSelector:@selector(si_descriptionWithLocale:)];
}

- (NSString *)si_descriptionWithLocale:(id)locale {
    NSString *desc = [self si_descriptionWithLocale:locale];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

@end

@implementation NSArray (_UnicodeTransfer)

+ (void)load {
    // 类加载会调用
    // 此处与自己写的方法指针
    [self exchangeSelector:@selector(descriptionWithLocale:) andNewSelector:@selector(si_descriptionWithLocale:)];
}


- (NSString *)si_descriptionWithLocale:(id)locale {
    NSString *desc = [self si_descriptionWithLocale:locale];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

@end
