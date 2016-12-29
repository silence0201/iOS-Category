//
//  NSObject+Runtime.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef void(^MethodEnumertor)(Class class, Method method);

@interface NSObject (Runtime)

- (NSDictionary *)propertyDictionary;
+ (NSArray *)classPropertyList;

+ (void)enumerateMethodList:(MethodEnumertor) enumerator ;
+ (IMP)replaceMethod:(SEL)originalSelector WithBlock:(id)block ;
+ (void)implementProperty:(NSString *)propertyName ;

#pragma mark - Swap method (Swizzling)
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


#pragma mark - Associate value
- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateWeakValue:(nullable id)value withKey:(void *)key;
- (nullable id)getAssociatedValueForKey:(void *)key;
- (void)removeAssociatedValues;

#pragma mark - Others

+ (NSString *)className;
- (NSString *)className;

- (nullable id)deepCopy;
- (nullable id)deepCopyWithArchiver:(Class)archiver unarchiver:(Class)unarchiver;


@end
