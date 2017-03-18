//
//  UIApplication+Permissions.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    SIPermissionTypeBluetoothLE,
    SIPermissionTypeCalendar,
    SIPermissionTypeContacts,
    SIPermissionTypeLocation,
    SIPermissionTypeMicrophone,
    SIPermissionTypeMotion,
    SIPermissionTypePhotos,
    SIPermissionTypeReminders,
} SIPermissionType;

typedef enum {
    SIPermissionAccessDenied,
    SIPermissionAccessGranted,
    SIPermissionAccessRestricted,
    SIPermissionAccessUnknown,
    SIPermissionAccessUnsupported,
    SIPermissionAccessMissingFramework,
} SIPermissionAccess;

@interface UIApplication (Permissions)

-(SIPermissionAccess)jk_hasAccessToBluetoothLE;
-(SIPermissionAccess)jk_hasAccessToCalendar;
-(SIPermissionAccess)jk_hasAccessToContacts;
-(SIPermissionAccess)jk_hasAccessToLocation;
-(SIPermissionAccess)jk_hasAccessToPhotos;
-(SIPermissionAccess)jk_hasAccessToReminders;

#pragma mark --- Request permission with callback
-(void)requestAccessToCalendarWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)requestAccessToContactsWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)requestAccessToMicrophoneWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)requestAccessToPhotosWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;
-(void)requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

#pragma mark --- Instance methods
-(void)requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied;

#pragma mark --- No failure callback available
-(void)requestAccessToMotionWithSuccess:(void(^)())accessGranted;

@end
