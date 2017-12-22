//
//  AuthorizationManager.m
//  AuthorizationManagerDemo
//
//  Created by Silence on 09/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIAuthorizationManager.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation SIAuthorizationManager

/// 单例
+ (instancetype)sharedManager{
    static SIAuthorizationManager *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init] ;
    });
    return manager ;
}

- (void)requestAuthorizationType:(SIAuthorizationType)type completion:(void (^)(BOOL, SIAuthorizationStatus))completion{
    switch (type) {
        case SIAuthorizationTypePhoto:
            [self requestAuthorizationTypePhotoCompletion:completion];
            break;
        case SIAuthorizationTypeCamera:
            [self requestAuthorizationTypeCameraCompletion:completion];
            break;
        case SIAuthorizationTypeMedia:
            [self requestAuthorizationTypeMediaCompletion:completion];
            break;
        case SIAuthorizationTypeMicrophone:
            [self requestAuthorizationTypeMicrophoneCompletion:completion];
            break;
        case SIAuthorizationTypeLocation:
            [self requestAuthorizationTypeLocationCompletion:completion];
            break;
        case SIAuthorizationTypeBluetooth:
            [self requestAuthorizationTypeBluetoothCompletion:completion];
            break;
        case SIAuthorizationTypePushNotification:
            [self requestAuthorizationTypePushNotificationCompletion:completion];
            break;
        case SIAuthorizationTypeSpeech:
            [self requestAuthorizationTypeSpeechCompletion:completion];
            break;
        case SIAuthorizationTypeEvent:
            [self requestAuthorizationTypeEventCompletion:completion];
            break;
        case SIAuthorizationTypeContact:
            [self requestAuthorizationType:SIAuthorizationTypeContact completion:completion];
            break;
        case SIAuthorizationTypeReminder:
            [self requestAuthorizationTypeReminderCompletion:completion];
            break;
        case SIAuthorizationTypeHealth:
            [self requestAuthorizationTypeHealthCompletion:completion];
            break;
        default:
            break;
    }
}

- (void)requestAuthorizationTypePhotoCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            completion(NO,SIAuthorizationStatusDenied);
        } else if (status == PHAuthorizationStatusNotDetermined) {
            completion(NO,SIAuthorizationStatusNotDetermined);
        } else if (status == PHAuthorizationStatusRestricted) {
            completion(NO,SIAuthorizationStatusRestricted);
        } else if (status == PHAuthorizationStatusAuthorized) {
            completion(YES,SIAuthorizationStatusAuthorized);
        }
    }];
}

- (void)requestAuthorizationTypeCameraCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (granted) {
            completion(YES,SIAuthorizationStatusAuthorized);
        } else {
            if (status == AVAuthorizationStatusDenied) {
                completion(NO,SIAuthorizationStatusDenied);
            } else if (status == AVAuthorizationStatusNotDetermined) {
                completion(NO,SIAuthorizationStatusNotDetermined);
            } else if (status == AVAuthorizationStatusRestricted) {
                completion(NO,SIAuthorizationStatusRestricted);
            }
        }
    }];
}

- (void)requestAuthorizationTypeMediaCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion{
    [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
        if (status == MPMediaLibraryAuthorizationStatusDenied) {
            completion(NO,SIAuthorizationStatusDenied);
        } else if (status == MPMediaLibraryAuthorizationStatusNotDetermined) {
            completion(NO,SIAuthorizationStatusNotDetermined);
        } else if (status == MPMediaLibraryAuthorizationStatusRestricted) {
            completion(NO,SIAuthorizationStatusRestricted);
        } else if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
            completion(YES,SIAuthorizationStatusAuthorized);
        }
    }];
}

- (void)requestAuthorizationTypeMicrophoneCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        if (granted) {
            completion(YES,SIAuthorizationStatusAuthorized);
        } else {
            if (status == AVAuthorizationStatusDenied) {
                completion(NO,SIAuthorizationStatusDenied);
            } else if (status == AVAuthorizationStatusNotDetermined) {
                completion(NO,SIAuthorizationStatusNotDetermined);
            } else if (status == AVAuthorizationStatusRestricted) {
                completion(NO,SIAuthorizationStatusRestricted);
            }
        }
    }];
}

- (void)requestAuthorizationTypeLocationCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    if ([CLLocationManager locationServicesEnabled]) {
        CLLocationManager *locationManager = [[CLLocationManager alloc]init];
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        locationManager.distanceFilter = 10;
        [locationManager startUpdatingLocation];
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        completion(YES,SIAuthorizationStatusLocationAlways);
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        completion(YES,SIAuthorizationStatusLocationWhenInUse);
    } else if (status == kCLAuthorizationStatusDenied) {
        completion(NO,SIAuthorizationStatusDenied);
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        completion(NO,SIAuthorizationStatusNotDetermined);
    } else if (status == kCLAuthorizationStatusRestricted) {
        completion(NO,SIAuthorizationStatusRestricted);
    }
}

- (void)requestAuthorizationTypeBluetoothCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    CBCentralManager *centralManager = [[CBCentralManager alloc] init];
    CBManagerState state = [centralManager state];
    if (state == CBManagerStateUnsupported || state == CBManagerStateUnauthorized || state == CBManagerStateUnknown) {
        completion(NO,SIAuthorizationStatusDenied);
    } else {
        completion(YES,SIAuthorizationStatusAuthorized);
    }
}

- (void)requestAuthorizationTypePushNotificationCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions types=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                }];
                completion(YES,SIAuthorizationStatusAuthorized);
            } else {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) { }];
            }
        }];
    }else if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0){
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }
}

- (void)requestAuthorizationTypeSpeechCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
            completion(NO,SIAuthorizationStatusDenied);
        } else if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            completion(NO,SIAuthorizationStatusNotDetermined);
        } else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
            completion(NO,SIAuthorizationStatusRestricted);
        } else if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
            completion(YES,SIAuthorizationStatusAuthorized);
        }
    }];
}

- (void)requestAuthorizationTypeEventCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    EKEventStore *store = [[EKEventStore alloc]init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
        if (granted) {
            completion(YES,SIAuthorizationStatusAuthorized);
        } else {
            if (status == EKAuthorizationStatusDenied) {
                completion(NO,SIAuthorizationStatusDenied);
            } else if (status == EKAuthorizationStatusNotDetermined) {
                completion(NO,SIAuthorizationStatusNotDetermined);
            } else if (status == EKAuthorizationStatusRestricted) {
                completion(NO,SIAuthorizationStatusRestricted);
            }
        }
    }];
}

- (void)requestAuthorizationTypeContactCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (granted) {
            completion(YES,SIAuthorizationStatusAuthorized);
        } else {
            if (status == CNAuthorizationStatusDenied) {
                completion(NO,SIAuthorizationStatusDenied);
            }else if (status == CNAuthorizationStatusRestricted){
                completion(NO,SIAuthorizationStatusNotDetermined);
            }else if (status == CNAuthorizationStatusNotDetermined){
                completion(NO,SIAuthorizationStatusRestricted);
            }
        }
    }];
}

- (void)requestAuthorizationTypeReminderCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
        if (granted) {
            completion(YES,SIAuthorizationStatusAuthorized);
        } else {
            if (status == EKAuthorizationStatusDenied) {
                completion(NO,SIAuthorizationStatusDenied);
            }else if (status == EKAuthorizationStatusNotDetermined){
                completion(NO,SIAuthorizationStatusNotDetermined);
            }else if (status == EKAuthorizationStatusRestricted){
                completion(NO,SIAuthorizationStatusRestricted);
            }
        }
    }];
}

- (void)requestAuthorizationTypeHealthCompletion:(void (^)(BOOL, SIAuthorizationStatus))completion {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        if (![HKHealthStore isHealthDataAvailable]) {
            NSAssert([HKHealthStore isHealthDataAvailable],@"Device not support HealthKit");
        }else{
            HKHealthStore *store = [[HKHealthStore alloc] init];
            NSSet *readObjectTypes = [self readObjectTypes];
            NSSet *writeObjectTypes = [self writeObjectTypes];
            [store requestAuthorizationToShareTypes:writeObjectTypes readTypes:readObjectTypes completion:^(BOOL success, NSError * _Nullable error) {
                if (success == YES) {
                    completion(YES,SIAuthorizationStatusAuthorized);
                }else{
                    completion(NO,SIAuthorizationStatusUnkonwn);
                }
            }];
        }
    }else{
        NSAssert([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0, @"iOS8 below systems are not currently supported");
    }
}


-(NSSet *)readObjectTypes{
    HKQuantityType *StepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *DistanceWalkingRunning= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *FlightsClimbed = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    return [NSSet setWithObjects:StepCount,DistanceWalkingRunning,FlightsClimbed, nil];
}
-(NSSet *)writeObjectTypes{
    HKQuantityType *StepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *DistanceWalkingRunning= [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKObjectType *FlightsClimbed = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    return [NSSet setWithObjects:StepCount,DistanceWalkingRunning,FlightsClimbed, nil];
}

@end

#pragma clang diagnostic pop
