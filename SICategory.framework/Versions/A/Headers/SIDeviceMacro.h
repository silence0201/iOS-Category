//
//  SIDevices.h
//  Category
//
//  Created by Silence on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// 屏幕信息
#define IS_RETINA_SCREE                          (MAIN_SCREEN.scale > 1.0)
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

// 设备类型
#define IS_IPHONE         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_6PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_X ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )812 ) < DBL_EPSILON )

// 设备信息
#define DEVICE_MODEL                                [CURRENT_DEVICE model]
#define DEVICE_LOCALIZED_MODEL                      [CURRENT_DEVICE localizedModel]
#define DEVICE_PLATFORM                             [CURRENT_DEVICE platform]
#define DEVICE_SYSTEM_NAME                          [CURRENT_DEVICE systemName]
#define DEVICE_SYSTEM_VERSION                       [CURRENT_DEVICE systemVersion]

// 系统版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)              ([[CURRENT_DEVICE systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_IS_IOS4_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0")
#define SYSTEM_VERSION_IS_IOS5_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define SYSTEM_VERSION_IS_IOS6_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define SYSTEM_VERSION_IS_IOS7_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define SYSTEM_VERSION_IS_IOS8_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define SYSTEM_VERSION_IS_IOS9_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define SYSTEM_VERSION_IS_IOS10_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")
#define SYSTEM_VERSION_IS_IOS11_OR_GREATER                     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")

// 设备尺寸信息
#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define NAVIGATION_BAR_HEIGHT 44
#define STATUS_BAR_ANDNAVIGATION_BAR_HEIGHT (IS_IPHONE_X ? 88.f : 64.f)
#define TABBAR_HEIGHT                (IS_IPHONE_X ? (49.f+34.f) : 49.f)
#define SAFE_BOTTOM_MARGIN_V         (IS_IPHONE_X ? 34.f : 0.f)
#define SAFE_BOTTOM_MARGIN_H         (IS_IPHONE_X ? 21.f : 0.f)
#define SAFE_LEFTORRIGHT_MARGIN_H         (IS_IPHONE_X ? 44.f : 0.f)
#define SAFE_INSETS(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})




