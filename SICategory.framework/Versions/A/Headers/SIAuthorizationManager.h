//
//  AuthorizationManager.h
//  AuthorizationManagerDemo
//
//  Created by Silence on 09/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,SIAuthorizationType) {
    SIAuthorizationTypePhoto = 0,
    SIAuthorizationTypeCamera,
    SIAuthorizationTypeMedia,
    SIAuthorizationTypeMicrophone,
    SIAuthorizationTypeLocation,
    SIAuthorizationTypeBluetooth,
    SIAuthorizationTypePushNotification,
    SIAuthorizationTypeSpeech,
    SIAuthorizationTypeEvent,
    SIAuthorizationTypeContact,
    SIAuthorizationTypeReminder,
    SIAuthorizationTypeHealth,
};

typedef NS_ENUM(NSUInteger,SIAuthorizationStatus) {
    SIAuthorizationStatusAuthorized = 0,
    SIAuthorizationStatusDenied,
    SIAuthorizationStatusNotDetermined,
    SIAuthorizationStatusRestricted,
    SIAuthorizationStatusLocationAlways,
    SIAuthorizationStatusLocationWhenInUse,
    SIAuthorizationStatusUnkonwn,
};


@interface SIAuthorizationManager : NSObject


/// 单例对象
+ (instancetype)sharedManager ;

- (void)requestAuthorizationType:(SIAuthorizationType)type
                     completion:(void(^)(BOOL response,SIAuthorizationStatus status))completion;


@end
