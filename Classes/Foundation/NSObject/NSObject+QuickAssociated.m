//
//  NSObject+QuickAssociated.m
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+QuickAssociated.h"
#import <objc/runtime.h>

@implementation NSObject (QuickAssociated)

- (void)quickAssociateValue:(id)value withKey:(void *)key withType:(AssociationPolicy)type{
    uintptr_t typeValue = type ;
    objc_setAssociatedObject(self, key, value, typeValue) ;
}

- (void)quickAssociateValue:(id)value withKey:(void *)key{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN) ;
}

- (void)quickWeaklyAssociateValue:(id)value withKey:(void *)key{
    objc_setAssociatedObject(self,key,value,OBJC_ASSOCIATION_ASSIGN) ;
}

- (void)quickCopyAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY) ;
}

- (id)quickGetAssociatedValueForKey:(void *)key{
    return objc_getAssociatedObject(self, key) ;
}

- (void)quickRemoveAssociatedValues{
    objc_removeAssociatedObjects(self) ;
}

@end
