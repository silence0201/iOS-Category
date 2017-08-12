//
//  SIMediatorManager.h
//  Category
//
//  Created by 杨晴贺 on 23/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIMediatorManager : NSObject

/// 单例对象
+ (instancetype)sharedManager;


/**
 远程App调用入口

 @param url 远程URL : aaa://targetA/actionB?id=1234
 @param completion CompletionBlock
 @return 返回的参数
 */
- (id)performActionWithUrl:(NSURL *)url
                completion:(void(^)(NSDictionary *info))completion;

/**
 本地组件调用入口

 @param targetClassName target Class Name
 @param actionName action Name
 @param params params
 @param shouldCacheTarget 是否缓存
 @return 返回的参数
 */
- (id)performTarget:(NSString *)targetClassName
             action:(NSString *)actionName
             params:(NSDictionary *)params
  shouldCacheTarget:(BOOL)shouldCacheTarget ;


/**
 清除Target缓存

 @param targetName targetName
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
