//
//  NSObject+QuickAssociated.h
//  Category
//
//  Created by Silence on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef OBJC_ENUM(unsigned long, AssociationPolicy) {
    PolicyASSIGN = 0,
    PolicyRETAIN_NONATOMIC = 1,
    PolicyCOPY_NONATOMIC = 3,
    PolicyRETAIN = 01401,
    PolicyCOPY = 01403
};

@interface NSObject (QuickAssociated)


/** 快速附加一个strong对象 */
- (void)quickAssociateValue:(id)value withKey:(void *)key;

/** 快速附加一个weak对象 */
- (void)quickWeaklyAssociateValue:(id)value withKey:(void *)key ;

/** 快速附加一个copy对象 */
- (void)quickCopyAssociateValue:(id)value withKey:(void *)key ;

/** 快速附加一个指定管理类型的对象 */
- (void)quickAssociateValue:(id)value withKey:(void *)key withType:(AssociationPolicy)type ;

/** 根据附加对象的key取出对应的对象 */
- (id)quickGetAssociatedValueForKey:(void *)key ;

/** 快速删除关联对象 */
- (void)quickRemoveAssociatedValues ;

@end
