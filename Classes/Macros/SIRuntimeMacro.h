//
//  SIRuntimeMacro.h
//  Category
//
//  Created by 杨晴贺 on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// runtime换类方法
#define ExchangeImplementations_Class_Method(_cls_, _sel_1, _sel_2) {\
Method method1 = class_getClassMethod(_cls_, _sel_1);\
Method method2 = class_getClassMethod(_cls_, _sel_2);\
ASSERT(method1 != NULL);\
ASSERT(method2 != NULL);\
SP_LOG(@"exchange [%@], +%@(0x%08lx) ==> +%@(0x%08lx), ", NSStringFromClass(_cls_), NSStringFromSelector(_sel_1), (long)method1, NSStringFromSelector(_sel_2), (long)method2);\
if (method1 && method2) {\
method_exchangeImplementations(method1, method2);\
}\
}

// runtime换实例方法
#define ExchangeImplementations_Class_Instance(_cls_, _sel_1, _sel_2) {\
Method method1 = class_getInstanceMethod(_cls_, _sel_1);\
Method method2 = class_getInstanceMethod(_cls_, _sel_2);\
ASSERT(method1 != NULL);\
ASSERT(method2 != NULL);\
SP_LOG(@"exchange (%@), -%@(0x%08lx) ==> -%@(0x%08lx), ", NSStringFromClass(_cls_), NSStringFromSelector(_sel_1), (long)method1, NSStringFromSelector(_sel_2), (long)method2);\
if (method1 && method2) {\
method_exchangeImplementations(method1, method2);\
}\
}
