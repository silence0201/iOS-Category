//
//  SIChainMacro.h
//  Category
//
//  Created by Silence on 2020/8/29.
//  Copyright © 2020年 silence. All rights reserved.
//

#define SIChainPropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)         \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                      \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define SIChainPropSetFuncImplementation(className, propertyPointerType, propertyName)                                     \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                     \
return ^(propertyPointerType propertyName) {                                                                                 \
_##propertyName = propertyName;                                                                                              \
return self;                                                                                                                 \
};                                                                                                                           \
}

