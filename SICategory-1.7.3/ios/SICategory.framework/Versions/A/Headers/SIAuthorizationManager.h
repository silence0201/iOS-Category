//
//  AuthorizationManager.h
//  AuthorizationManagerDemo
//
//  Created by 杨晴贺 on 09/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SIAuthorizationType) {
    SIAuthorizationTypePhotoLibrary,   /// 图库
    SIAuthorizationTypeLocationAlways, /// 永久地理位置
    SIAuthorizationTypeLocationUse,    /// 当使用地理位置
    SIAuthorizationTypeAddressBook,    /// 通讯录
    SIAuthorizationTypeAudio,          /// 语音
    SIAuthorizationTypeCamera          /// 相机
};

@interface SIAuthorizationManager : NSObject


/**
    单例对象

    @return 对象
 */
+ (instancetype)sharedManager ;


/**
    申请授权

    @param type 授权类型
    @return 是否申请成功
 */
- (BOOL)requestAuthorizationType:(SIAuthorizationType)type ;

@end
