//
//  UIApplication+Authority.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Authority)

@property (nonatomic,readonly) BOOL isAccessToLocationData ;
@property (nonatomic,readonly) BOOL isAccessToAddressBook;
@property (nonatomic,readonly) BOOL isAccessToCalendar ;
@property (nonatomic,readonly) BOOL isAccessToReminders ;
@property (nonatomic,readonly) BOOL isAccessToPhotosLibrary ;
@property (nonatomic,readonly) BOOL isAccessToMicrophone NS_AVAILABLE_IOS(8_0);

@end
