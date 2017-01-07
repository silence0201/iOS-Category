//
//  UIDevice+NetWork.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
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

@property (nonatomic,readonly) NSString *macAddress ;

@property (nonatomic,readonly) NSString *ipAddressWIFI ;
@property (nonatomic,readonly) NSString *ipAddressCell ;

@property (nonatomic,readonly) UIDeviceNetType networkType ;
@end
