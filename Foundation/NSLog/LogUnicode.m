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

/// 将字符串中的Unicode编码字符（如\Uxxxx等）转为汉字
- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSData *data = [unicodeStr dataUsingEncoding:NSUTF8StringEncoding];
    const uint8_t *bytes = data.bytes;
    NSMutableString *mStr = [NSMutableString string];
    for (NSInteger i = 0; i < data.length; i++) {
        if (i + 5 < data.length && bytes[i] == '\\' && bytes[i+1] == 'U') {
            uint8_t byte1 = [self convertHex:bytes[i + 2]];
            uint8_t byte2 = [self convertHex:bytes[i + 3]];
            uint8_t byte3 = [self convertHex:bytes[i + 4]];
            uint8_t byte4 = [self convertHex:bytes[i + 5]];
            if (byte1 && byte2 && byte3 && byte4) {
                unichar c = byte1 * 4096 + byte2 * 256 + byte3 * 16 + byte4 - 4369;
                NSString *tstr = [NSString stringWithCharacters:&c length:1];
                [mStr appendString:tstr];
                i += 5;
            } else {
                [mStr appendFormat:@"%c", bytes[i]];
            }
        } else {
            [mStr appendFormat:@"%c", bytes[i]];
        }
    }
    return [mStr copy];
}

- (uint8_t)convertHex:(uint8_t)byte {
    if (byte >= 48 && byte <= 57) {
        return byte - 48 + 1;
    }
    if (byte >= 97 && byte <= 102) {
        return byte - 87 + 1;
    }
    if (byte >= 65 && byte <= 80) {
        return byte - 55 + 1;
    }
    return 0;
}

@end

@implementation NSDictionary (_UnicodeTransfer)

+ (void)load {
    // 类加载的时候会调用的
    // 此处与自己写的方法指针
    [self exchangeSelector:@selector(descriptionWithLocale:) andNewSelector:@selector(si_descriptionWithLocale:)];
    if ([self instancesRespondToSelector:@selector(descriptionWithLocale:indent:)]) {
        [self exchangeSelector:@selector(descriptionWithLocale:indent:) andNewSelector:@selector(si_descriptionWithLocale:indent:)];
    }
}

- (NSString *)si_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *desc = [self si_descriptionWithLocale:(id)locale indent:(NSUInteger)level];
    if (level == 0) {
        desc = [self replaceUnicode:desc];
    }
    return desc;
}

- (NSString *)si_descriptionWithLocale:(id)locale {
    NSString *desc = [self si_descriptionWithLocale:locale];
    desc = [self replaceUnicode:desc];
    return desc;
}

@end

@implementation NSArray (_UnicodeTransfer)

+ (void)load {
    // 类加载会调用
    // 此处与自己写的方法指针
    [self exchangeSelector:@selector(descriptionWithLocale:) andNewSelector:@selector(si_descriptionWithLocale:)];
    if ([self instancesRespondToSelector:@selector(descriptionWithLocale:indent:)]) {
        [self exchangeSelector:@selector(descriptionWithLocale:indent:) andNewSelector:@selector(si_descriptionWithLocale:indent:)];
    }
}

- (NSString *)si_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSString *desc = [self si_descriptionWithLocale:(id)locale indent:(NSUInteger)level];
    if (level == 0) {
        desc = [self replaceUnicode:desc];
    }
    return desc;
}

- (NSString *)si_descriptionWithLocale:(id)locale {
    NSString *desc = [self si_descriptionWithLocale:locale];
    desc = [self replaceUnicode:desc];
    return desc;
}

@end
