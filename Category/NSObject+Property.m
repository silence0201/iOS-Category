//
//  NSObject+Property.m
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

+ (instancetype)objectWithDictionary:(NSDictionary *)dic{
    id obj = [[self alloc]init] ;
    
    // 获取所有的成员变量
    unsigned int count ;
    Ivar *ivars = class_copyIvarList(self, &count) ;
    for(int i = 0 ;i < count ;i++){
        Ivar ivar = ivars[i] ;
        // 取出的成员变量,去掉下划线
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)] ;
        NSString *key = [ivarName substringFromIndex:1] ;
        
        id value = dic[key] ;
        
        // 当这个值为空时,判断一下是否执行eplacedKeyFromPropertyName协议，如果执行了替换原来的key查值
        if(!value){
            if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
                NSString *replaceKey = [self replacedKeyFromPropertyName][key] ;
                value = dic[replaceKey] ;
            }
        }
        
        // 字典嵌套字典
        if([value isKindOfClass:[NSDictionary class]]){
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)] ;
            NSRange range = [type rangeOfString:@"\""] ;
            type = [type substringToIndex:range.location] ;
            Class modelClass = NSClassFromString(type) ;
            
            if(modelClass){
                value = [modelClass objectWithDictionary:value] ;
            }
        }
        
        // 字典嵌套数组
        if([value isKindOfClass:[NSArray class]]){
            if ([self respondsToSelector:@selector(objectClassInArray)]) {
                NSMutableArray *models = [NSMutableArray array] ;
                NSString *type = [self objectClassInArray][key] ;
                Class classModel = NSClassFromString(type) ;
                for(NSDictionary *dic in value){
                    id model = [classModel objectWithDictionary:dic] ;
                    [models addObject:model] ;
                }
                value = models ;
            }
        }
        if (value) {
            [obj setValue:value forKey:key] ;
        }
    }
    free(ivars) ;
    
    return obj ;
}

@end
