//
//  UIDevice+NetWork.h
//  Category
//
//  Created by Silence on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIDeviceNetType) {
    UIDeviceNetTypeUnknow,
    UIDeviceNetTypeNot,
    UIDeviceNetType2G,
    UIDeviceNetType3G,
    UIDeviceNetType4G,
    UIDeviceNetTypeWIFI
};

@interface UIDevice (NetWork)

@property (nonatomic,readonly) NSString *macAddress ;   /// MAC地址

@property (nonatomic,readonly) NSString *ipAddressWIFI ;  /// 是否为WIFI
@property (nonatomic,readonly) NSString *ipAddressCell ;   /// 是否为蜂窝煤网络

@property (nonatomic,readonly) UIDeviceNetType networkType ;  /// 网络类型
@end
