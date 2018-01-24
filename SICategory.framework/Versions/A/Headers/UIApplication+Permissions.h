//
//  UIApplication+Permissions.h
//  Category
//
//  Created by Silence on 2017/3/18.
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

-(SIPermissionAccess)hasAccessToBluetoothLE;
-(SIPermissionAccess)hasAccessToCalendar;
-(SIPermissionAccess)hasAccessToContacts;
-(SIPermissionAccess)hasAccessToLocation;
-(SIPermissionAccess)hasAccessToPhotos;
-(SIPermissionAccess)hasAccessToReminders;

#pragma mark --- Request permission with callback
-(void)requestAccessToCalendarWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
-(void)requestAccessToContactsWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
-(void)requestAccessToMicrophoneWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
-(void)requestAccessToPhotosWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;
-(void)requestAccessToRemindersWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;

#pragma mark --- Instance methods
-(void)requestAccessToLocationWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied;

#pragma mark --- No failure callback available
-(void)requestAccessToMotionWithSuccess:(void(^)(void))accessGranted;

@end
