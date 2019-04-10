//
//  SIProxyManager.h
//  Category
//
//  Created by Silence on 2018/9/27.
//  Copyright © 2018年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 将消息进行分发
@interface SIProxyManager : NSObject

- (void)addTarger:(id)target;
- (void)removeTarget:(id)target;

@property (nonatomic,strong,readonly) NSPointerArray *targets;

@end

NS_ASSUME_NONNULL_END
