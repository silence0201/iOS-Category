//
//  SIAppVersionManager.h
//  Category
//
//  Created by 杨晴贺 on 24/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIAppVersionManager : NSObject

/// 单例
+ (SIAppVersionManager *)sharedManager ;

/// 检查新版本
- (void)checkVersionWithAppID:(NSString *)appID showNewestMsg:(BOOL)showMsg;

@end
