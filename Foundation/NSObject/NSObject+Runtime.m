//
//  NSObject+Runtime.m
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+Runtime.h"


@implementation NSObject (Runtime)

-(NSDictionary *)propertyDictionary{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for(int i=0;i<outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        if(propValue){
            [dict setObject:propValue forKey:propName];
        }
    }
    free(props);
    return dict;
}

+ (NSArray *)classPropertyList {
    NSMutableArray *allProperties = [[NSMutableArray alloc] init];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        if (propName) {
            [allProperties addObject:propName];
        }
    }
    free(props);
    return [NSArray arrayWithArray:allProperties];
}


+ (void)enumerateMethodList:(MethodEnumertor)enumerator{
    Class class = [self class] ;
    if (!enumerator) return;
    
    static dispatch_queue_t queue = NULL;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("de.ebf.objc_runtime_additions.method_enumeration_queue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(class, &methodCount);
    
    dispatch_apply(methodCount, queue, ^(size_t index) {
        Method method = methods[index];
        enumerator(class, method);
    });
    
    free(methods);

}

+ (IMP)replaceMethod:(SEL)originalSelector WithBlock:(id)block{
    Class class = [self class] ;
    IMP newImplementation = imp_implementationWithBlock(block);
    Method method = class_getInstanceMethod(class, originalSelector);
    return class_replaceMethod(class, originalSelector, newImplementation, method_getTypeEncoding(method));
}

+ (void)implementProperty:(NSString *)propertyName{
    Class class = [self class] ;
    NSCAssert(class != Nil, @"class is required");
    NSCAssert(propertyName != nil, @"propertyName is required");
    
    objc_property_t property = class_getProperty(class, propertyName.UTF8String);
    
    unsigned int count = 0;
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &count);
    
    typedef enum {
        MemoryManagementAssign,
        MemoryManagementCopy,
        MemoryManagementRetain
    } MemoryManagement;
    
    MemoryManagement memoryManagement = MemoryManagementAssign;
    BOOL isNonatomic = NO;
    
    NSString *getterName = nil;
    NSString *setterName = nil;
    NSString *encoding = nil;
    
    for (int i = 0; i < count; i++) {
        objc_property_attribute_t attribute = attributes[i];
        
        switch (attribute.name[0]) {
            case 'N':
                isNonatomic = YES;
                break;
            case '&':
                memoryManagement = MemoryManagementRetain;
                break;
            case 'C':
                memoryManagement = MemoryManagementCopy;
                break;
            case 'G':
                getterName = [NSString stringWithFormat:@"%s", attribute.value];
                break;
            case 'S':
                setterName = [NSString stringWithFormat:@"%s", attribute.value];
                break;
            case 'T':
                encoding = [NSString stringWithFormat:@"%s", attribute.value];
                break;
            case 'W':
                NSCAssert(NO, @"weak properties are not supported");
                break;
            default:
                break;
        }
    }
    
    if (!getterName) {
        getterName = propertyName;
    }
    
    if (!setterName) {
        NSString *firstLetter = [propertyName substringToIndex:1];
        setterName = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"set%@", firstLetter.uppercaseString]];
        setterName = [setterName stringByAppendingString:@":"];
    }
    
    NSCAssert([encoding characterAtIndex:0] != '{', @"structs are not supported");
    NSCAssert([encoding characterAtIndex:0] != '(', @"unions are not supported");
    
    SEL getter = NSSelectorFromString(getterName);
    SEL setter = NSSelectorFromString(setterName);
    
    if (encoding.UTF8String[0] == @encode(id)[0]) {
        IMP getterImplementation = imp_implementationWithBlock(^id(id self) {
            return objc_getAssociatedObject(self, getter);
        });
        
        objc_AssociationPolicy associationPolicy = 0;
        
        if (memoryManagement == MemoryManagementCopy) {
            associationPolicy = isNonatomic ? OBJC_ASSOCIATION_COPY_NONATOMIC : OBJC_ASSOCIATION_COPY;
        } else {
            associationPolicy = isNonatomic ? OBJC_ASSOCIATION_RETAIN_NONATOMIC : OBJC_ASSOCIATION_RETAIN;
        }
        
        IMP setterImplementation = imp_implementationWithBlock(^(id self, id object) {
            objc_setAssociatedObject(self, getter, object, associationPolicy);
        });
        
        class_addMethod(class, getter, getterImplementation, "@@:");
        class_addMethod(class, setter, setterImplementation, "v@:@");
        
        return;
    }
    
    objc_AssociationPolicy associationPolicy = isNonatomic ? OBJC_ASSOCIATION_RETAIN_NONATOMIC : OBJC_ASSOCIATION_RETAIN;
    
#define CASE(type, selectorpart) if (encoding.UTF8String[0] == @encode(type)[0]) {\
IMP getterImplementation = imp_implementationWithBlock(^type(id self) {\
return [objc_getAssociatedObject(self, getter) selectorpart##Value];\
});\
\
IMP setterImplementation = imp_implementationWithBlock(^(id self, type object) {\
objc_setAssociatedObject(self, getter, @(object), associationPolicy);\
});\
\
class_addMethod(class, getter, getterImplementation, "@@:");\
class_addMethod(class, setter, setterImplementation, "v@:@");\
\
return;\
}
    
    CASE(char, char);
    CASE(unsigned char, unsignedChar);
    CASE(short, short);
    CASE(unsigned short, unsignedShort);
    CASE(int, int);
    CASE(unsigned int, unsignedInt);
    CASE(long, long);
    CASE(unsigned long, unsignedLong);
    CASE(long long, longLong);
    CASE(unsigned long long, unsignedLongLong);
    CASE(float, float);
    CASE(double, double);
    CASE(BOOL, bool);
    
#undef CASE
    
    NSCAssert(NO, @"encoding %@ in not supported", encoding);

}


+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

- (void)setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

- (id)deepCopy {
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    return obj;
}

- (id)deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver {
    id obj = nil;
    @try {
        obj = [unarchiver unarchiveObjectWithData:[archiver archivedDataWithRootObject:self]];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    return obj;
}

@end
