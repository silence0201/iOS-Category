//
//  NSObject+AutoCoding.m
//  Category
//
//  Created by 杨晴贺 on 2017/5/10.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSObject+AutoCoding.h"

#import <objc/runtime.h>


#pragma clang diagnostic ignored "-Wgnu"
#pragma clang diagnostic ignored "-Wpartial-availability"
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"


static NSString *const AutocodingException = @"AutocodingException";


@implementation NSObject (AutoCoding)

+ (BOOL)supportsSecureCoding {
    return YES;
}

+ (instancetype)objectWithContentsOfFile:(NSString *)filePath{
    // 加载文件
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 尝试转化plist
    id object = nil;
    if (data){
        NSPropertyListFormat format;
        object = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:NULL];
        
        // 是否成功
        if (object){
            // 是否为归档
            if ([object respondsToSelector:@selector(objectForKeyedSubscript:)] && ((NSDictionary *)object)[@"$archiver"]){
                object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }else{
            // 返回原始数据
            object = data;
        }
    }
    
    // 返回对象
    return object;
}

- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile{
    // 固化对象
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:filePath atomically:useAuxiliaryFile];
}

+ (NSDictionary<NSString *, Class> *)codableProperties{
    SEL deprecatedSelector = NSSelectorFromString(@"uncodableProperties");
    NSArray *uncodableProperties = nil;
    if ([self respondsToSelector:deprecatedSelector] || [self instancesRespondToSelector:deprecatedSelector]){
        uncodableProperties = [self valueForKey:@"uncodableProperties"];
        NSLog(@"AutoCoding Warning: uncodableProperties method is no longer supported. Use ivars, or synthesize your properties using non-KVC-compliant names to avoid coding them instead.");
    }
    
    unsigned int propertyCount;
    __autoreleasing NSMutableDictionary *codableProperties = [NSMutableDictionary dictionary];
    objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++){
        // 获取属性名
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        __autoreleasing NSString *key = @(propertyName);
        if (![uncodableProperties containsObject:key]){
            Class propertyClass = nil;
            char *typeEncoding = property_copyAttributeValue(property, "T");
            switch (typeEncoding[0]){
                case '@':
                {
                    if (strlen(typeEncoding) >= 3){
                        char *className = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);
                        __autoreleasing NSString *name = @(className);
                        NSRange range = [name rangeOfString:@"<"];
                        if (range.location != NSNotFound){
                            name = [name substringToIndex:range.location];
                        }
                        propertyClass = NSClassFromString(name) ?: [NSObject class];
                        free(className);
                    }
                    break;
                }
                case 'c':
                case 'i':
                case 's':
                case 'l':
                case 'q':
                case 'C':
                case 'I':
                case 'S':
                case 'L':
                case 'Q':
                case 'f':
                case 'd':
                case 'B':
                {
                    propertyClass = [NSNumber class];
                    break;
                }
                case '{':
                {
                    propertyClass = [NSValue class];
                    break;
                }
            }
            free(typeEncoding);
            
            if (propertyClass){
                char *ivar = property_copyAttributeValue(property, "V");
                if (ivar){
                    __autoreleasing NSString *ivarName = @(ivar);
                    if ([ivarName isEqualToString:key] || [ivarName isEqualToString:[@"_" stringByAppendingString:key]]){
                        codableProperties[key] = propertyClass;
                    }
                    free(ivar);
                }else{
                    char *dynamic = property_copyAttributeValue(property, "D");
                    char *readonly = property_copyAttributeValue(property, "R");
                    if (dynamic && !readonly){
                        codableProperties[key] = propertyClass;
                    }
                    free(dynamic);
                    free(readonly);
                }
            }
        }
    }
    
    free(properties);
    return codableProperties;
}

- (NSDictionary<NSString *, Class> *)codableProperties{
    __autoreleasing NSDictionary *codableProperties = objc_getAssociatedObject([self class], _cmd);
    if (!codableProperties){
        codableProperties = [NSMutableDictionary dictionary];
        Class subclass = [self class];
        while (subclass != [NSObject class]){
            [(NSMutableDictionary *)codableProperties addEntriesFromDictionary:[subclass codableProperties]];
            subclass = [subclass superclass];
        }
        codableProperties = [NSDictionary dictionaryWithDictionary:codableProperties];
        
        objc_setAssociatedObject([self class], _cmd, codableProperties, OBJC_ASSOCIATION_RETAIN);
    }
    return codableProperties;
}

- (NSDictionary<NSString *, id> *)dictionaryRepresentation{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (__unsafe_unretained NSString *key in self.codableProperties){
        id value = [self valueForKey:key];
        if (value) dict[key] = value;
    }
    return dict;
}

- (void)setWithCoder:(NSCoder *)aDecoder{
    BOOL secureAvailable = [aDecoder respondsToSelector:@selector(decodeObjectOfClass:forKey:)];
    BOOL secureSupported = [[self class] supportsSecureCoding];
    NSDictionary *properties = self.codableProperties;
    for (NSString *key in properties){
        id object = nil;
        Class propertyClass = properties[key];
        if (secureAvailable){
            object = [aDecoder decodeObjectOfClass:propertyClass forKey:key];
        }else{
            object = [aDecoder decodeObjectForKey:key];
        }
        
        if (object){
            if (secureSupported && ![object isKindOfClass:propertyClass] && object != [NSNull null]){
                [NSException raise:AutocodingException format:@"Expected '%@' to be a %@, but was actually a %@", key, propertyClass, [object class]];
            }
            [self setValue:object forKey:key];
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    [self setWithCoder:aDecoder];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    for (NSString *key in self.codableProperties){
        id object = [self valueForKey:key];
        if (object) [aCoder encodeObject:object forKey:key];
    }
}

@end

