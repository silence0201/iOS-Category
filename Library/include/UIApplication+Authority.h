//
//  UIApplication+Authority.h
//  Category
//
//  Created by Silence on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Authority)

@property (nonatomic,readonly) BOOL isAccessToLocationData ; /// 是否可以获取定位信息
@property (nonatomic,readonly) BOOL isAccessToAddressBook; /// 是否可以获取通讯录信息
@property (nonatomic,readonly) BOOL isAccessToCalendar ; /// 是否可以获取日历访问权限
@property (nonatomic,readonly) BOOL isAccessToReminders ;  /// 是否可以获取备忘录
@property (nonatomic,readonly) BOOL isAccessToPhotosLibrary ;  /// 是否可以访问图库
@property (nonatomic,readonly) BOOL isAccessToMicrophone NS_AVAILABLE_IOS(8_0);   /// 是否可以获取麦克风权限

@end
