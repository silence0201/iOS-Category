//
//  UIApplication+Permissions.m
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIApplication+Permissions.h"
#import <objc/runtime.h>

//Import required frameworks
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>

typedef void (^SILocationSuccessCallback)(void);
typedef void (^SILocationFailureCallback)(void);

static char SIPermissionsLocationManagerPropertyKey;
static char SIPermissionsLocationBlockSuccessPropertyKey;
static char SIPermissionsLocationBlockFailurePropertyKey;

@interface UIApplication () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *permissionsLocationManager;
@property (nonatomic, copy) SILocationSuccessCallback locationSuccessCallbackProperty;
@property (nonatomic, copy) SILocationFailureCallback locationFailureCallbackProperty;
@end


@implementation UIApplication (Permissions)


#pragma mark - Check permissions
-(SIPermissionAccess)hasAccessToBluetoothLE {
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return SIPermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return SIPermissionAccessDenied;
            break;
            
        default:
            return SIPermissionAccessGranted;
            break;
    }
}

-(SIPermissionAccess)hasAccessToCalendar {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return SIPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return SIPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return SIPermissionAccessRestricted;
            break;
            
        default:
            return SIPermissionAccessUnknown;
            break;
    }
}

-(SIPermissionAccess)hasAccessToContacts {
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return SIPermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return SIPermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return SIPermissionAccessRestricted;
            break;
            
        default:
            return SIPermissionAccessUnknown;
            break;
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
-(SIPermissionAccess)hasAccessToLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorized:
            return SIPermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return SIPermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return SIPermissionAccessRestricted;
            break;
            
        default:
            return SIPermissionAccessUnknown;
            break;
    }
    return SIPermissionAccessUnknown;
}
#pragma clang diagnostic pop

-(SIPermissionAccess)hasAccessToPhotos {
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return SIPermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return SIPermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return SIPermissionAccessRestricted;
            break;
            
        default:
            return SIPermissionAccessUnknown;
            break;
    }
}

-(SIPermissionAccess)hasAccessToReminders {
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return SIPermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return SIPermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return SIPermissionAccessRestricted;
            break;
            
        default:
            return SIPermissionAccessUnknown;
            break;
    }
    return SIPermissionAccessUnknown;
}


#pragma mark - Request permissions
-(void)requestAccessToCalendarWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)(void))accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)requestAccessToContactsWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)())accessDenied {
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook) {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    accessGranted();
                } else {
                    accessDenied();
                }
            });
        });
    }
}

-(void)requestAccessToMicrophoneWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)())accessDenied {
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}

-(void)requestAccessToMotionWithSuccess:(void(^)(void))accessGranted {
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        accessGranted();
        [motionManager stopActivityUpdates];
    }];
}

-(void)requestAccessToPhotosWithSuccess:(void(^)(void))accessGranted andFailure:(void(^)())accessDenied {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        accessGranted();
    } failureBlock:^(NSError *error) {
        accessDenied();
    }];
}

-(void)requestAccessToRemindersWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                accessGranted();
            } else {
                accessDenied();
            }
        });
    }];
}


#pragma mark - Needs investigating
-(void)requestAccessToLocationWithSuccess:(void(^)())accessGranted andFailure:(void(^)())accessDenied {
    self.permissionsLocationManager = [[CLLocationManager alloc] init];
    self.permissionsLocationManager.delegate = self;
    
    self.locationSuccessCallbackProperty = accessGranted;
    self.locationFailureCallbackProperty = accessDenied;
    [self.permissionsLocationManager startUpdatingLocation];
}


#pragma mark - Location manager injection
-(CLLocationManager *)SI_permissionsLocationManager {
    return objc_getAssociatedObject(self, &SIPermissionsLocationManagerPropertyKey);
}

-(void)setSI_permissionsLocationManager:(CLLocationManager *)manager {
    objc_setAssociatedObject(self, &SIPermissionsLocationManagerPropertyKey, manager, OBJC_ASSOCIATION_RETAIN);
}

-(SILocationSuccessCallback)locationSuccessCallbackProperty {
    return objc_getAssociatedObject(self, &SIPermissionsLocationBlockSuccessPropertyKey);
}

-(void)setSI_locationSuccessCallbackProperty:(SILocationSuccessCallback)locationCallbackProperty {
    objc_setAssociatedObject(self, &SIPermissionsLocationBlockSuccessPropertyKey, locationCallbackProperty, OBJC_ASSOCIATION_COPY);
}

-(SILocationFailureCallback)locationFailureCallbackProperty {
    return objc_getAssociatedObject(self, &SIPermissionsLocationBlockFailurePropertyKey);
}

-(void)setSI_locationFailureCallbackProperty:(SILocationFailureCallback)locationFailureCallbackProperty {
    objc_setAssociatedObject(self, &SIPermissionsLocationBlockFailurePropertyKey, locationFailureCallbackProperty, OBJC_ASSOCIATION_COPY);
}


#pragma mark - Location manager delegate
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorized) {
        self.locationSuccessCallbackProperty();
    } else if (status != kCLAuthorizationStatusNotDetermined) {
        self.locationFailureCallbackProperty();
    }
}
#pragma clang diagnostic pop

@end

