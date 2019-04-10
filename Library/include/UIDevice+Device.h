//
//  UIDevice+Device.h
//  Category
//
//  Created by Silence on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef kSystemVersion
#define kSystemVersion [UIDevice systemVersion]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif


typedef NS_ENUM(NSUInteger, Hardware) {
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    
    IPHONE_6,
    IPHONE_6_PLUS,
    IPHONE_6S,
    IPHONE_6S_PLUS,
    IPHONE_SE,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    IPOD_TOUCH_6G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    IPAD_MINI_3_WIFI,
    IPAD_MINI_3_WIFI_CELLULAR,
    IPAD_MINI_3_WIFI_CELLULAR_CN,
    IPAD_MINI_4_WIFI,
    IPAD_MINI_4_WIFI_CELLULAR,
    
    IPAD_MINI_RETINA_WIFI_CELLULAR_CN,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    IPAD_AIR_2_WIFI,
    IPAD_AIR_2_WIFI_CELLULAR,
    
    IPAD_PRO_97_WIFI,
    IPAD_PRO_97_WIFI_CELLULAR,
    
    IPAD_PRO_WIFI,
    IPAD_PRO_WIFI_CELLULAR,
    
    SIMULATOR,
    
    HARDWARE_MAX
};

typedef enum {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyiPadMini,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
    
} DeviceFamily;



@interface UIDevice (Device)

@property (nonatomic,readonly) BOOL isPad;    /// 设备是否为iPad
@property (nonatomic,readonly) BOOL isSimulator;  /// 设备是否为虚拟机
@property (nonatomic,readonly) BOOL isJailbroken;  /// 设备是否越狱
@property (nonatomic,readonly) BOOL isRetina;   /// 设备是否为Retina屏
@property (nonatomic,readonly) BOOL hasCamera ;  /// 设备是否有照相机
@property (nonatomic,readonly) BOOL canCallPhone ;  /// 设备是否能打电话

@property (nonatomic,readonly) NSDate *systemUptime ;  /// 设备启动时间

@property (nonatomic,readonly) NSString *hardwareString ;  /// 设备描述信息
@property (nonatomic,readonly) Hardware hardware ;   /// 设备类型
@property (nonatomic,readonly) NSString *hardwareDesc ;   /// 设备简单描述

@property (nonatomic,readonly) DeviceFamily deviceFamily ;   /// 设备Family

@end
