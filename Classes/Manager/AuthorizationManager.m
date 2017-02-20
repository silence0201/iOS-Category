//
//  AuthorizationManager.m
//  AuthorizationManagerDemo
//
//  Created by 杨晴贺 on 09/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "AuthorizationManager.h"
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface AuthorizationAlter: UIAlertView<UIAlertViewDelegate>

+ (void)showAuthorizationAlertWithTitle:(NSString *)content;

@end

@implementation AuthorizationAlter

- (instancetype)initWithTitle:(NSString *)content{
    self = [super initWithTitle:content
                        message:nil
                       delegate:self
              cancelButtonTitle:@"取消"
              otherButtonTitles:@"去设置", nil] ;
    return self ;
}

+ (void)showAuthorizationAlertWithTitle:(NSString *)content{
    dispatch_async(dispatch_get_main_queue(), ^{
        AuthorizationAlter *alter = [[AuthorizationAlter alloc]initWithTitle:content] ;
        [alter show] ;
    }) ;
}

#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.cancelButtonIndex != buttonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil] ;
    }
}

@end

@interface AuthorizationManager ()<CLLocationManagerDelegate>

@end

@implementation AuthorizationManager{
    NSString *_appDisplayName ;
    CLLocationManager *_locationManager ;
}

/// 单例
+ (instancetype)sharedInstance{
    static AuthorizationManager *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init] ;
    });
    return manager ;
}

- (instancetype)init{
    if(self = [super init]){
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary] ;
        _appDisplayName = [infoDictionary objectForKey:@"CFBundleName"] ;
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return self ;
}

- (BOOL)requestAuthorizationType:(SIAuthorizationType)type{
    switch (type) {
        case SIAuthorizationTypePhotoLibrary:
            return [self requestAuthorizationPhotoLibrary] ;
            break;
        case SIAuthorizationTypeLocationAlways:
            return [self requestAuthorizationLocationAlways] ;
            break ;
        case SIAuthorizationTypeLocationUse:
            return [self requestAuthorizationLocationUse] ;
            break ;
        case SIAuthorizationTypeAddressBook:
            return [self requestAuthorizationAddressBook] ;
            break ;
        case SIAuthorizationTypeAudio:
            return [self requestAuthorizationAudio] ;
            break ;
        case SIAuthorizationTypeCamera:
            return [self requestAuthorizationCamera] ;
            break ;
        default:
            break;
    }
    
    return NO ;
}

- (BOOL)requestAuthorizationPhotoLibrary{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        PHAuthorizationStatus authStatus = [PHPhotoLibrary   authorizationStatus];
        if (authStatus == PHAuthorizationStatusNotDetermined) {
            __block BOOL canPh = YES;
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                canPh = status == PHAuthorizationStatusAuthorized ;
            }] ;
            return canPh ;
        }else if (authStatus != PHAuthorizationStatusAuthorized){
            NSString *content = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相册“选项中，允许%@访问你的手机相册",_appDisplayName];
            [AuthorizationAlter showAuthorizationAlertWithTitle:content] ;
        }
    }else{
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"设备不支持" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil] ;
        [alter show] ;
        return NO ;
    }
    return YES ;
}

- (BOOL)requestAuthorizationLocationAlways{
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus] ;
    if (authStatus == kCLAuthorizationStatusNotDetermined){
        if([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_locationManager requestAlwaysAuthorization];  // 永久授权
        }
    }else if(authStatus == !kCLAuthorizationStatusAuthorizedAlways){
        NSString *content = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-定位“选项中，允许%@访问你的总是定位",_appDisplayName];
        [AuthorizationAlter showAuthorizationAlertWithTitle:content] ;
        return NO ;
    }
    
    return YES ;
}

- (BOOL)requestAuthorizationLocationUse{
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus] ;
    if (authStatus == kCLAuthorizationStatusNotDetermined){
        if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];  // 使用时授权
        }
    }else if(authStatus == !kCLAuthorizationStatusAuthorizedWhenInUse){
        NSString *content = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-定位“选项中，允许%@访问你的使用时定位",_appDisplayName];
        [AuthorizationAlter showAuthorizationAlertWithTitle:content] ;
        return NO ;
    }
    return YES ;
}

- (BOOL)requestAuthorizationAddressBook{
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus() ;
    if (authStatus == kABAuthorizationStatusNotDetermined){
        __block BOOL canAdd = YES;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            canAdd = granted ;
        });
        CFRelease(addressBook);
        return canAdd ;
    }else if(authStatus != kABAuthorizationStatusAuthorized){
        NSString *content = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-联系人“选项中，允许%@访问你的手机通讯录",_appDisplayName];
        [AuthorizationAlter showAuthorizationAlertWithTitle:content] ;
        return NO ;
    }
    return YES ;
}

- (BOOL)requestAuthorizationAudio{
    __block BOOL canRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                canRecord = YES;
            } else {
                NSString *content = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-麦克风“选项中，允许%@访问你的麦克风",_appDisplayName];
                [AuthorizationAlter showAuthorizationAlertWithTitle:content] ;
                canRecord = NO;
            }
        }];
    }
    return canRecord ;
}

- (BOOL)requestAuthorizationCamera{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == ALAuthorizationStatusNotDetermined) {
            __block BOOL grn = NO ;
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                grn = granted ;
            }] ;
            return grn ;
        }
        if(authStatus != ALAuthorizationStatusAuthorized){
            NSString *content = [NSString stringWithFormat:@"请在iPhone的”设置-隐私-相机“选项中，允许%@访问你的手机相机",_appDisplayName]
            ;
            [AuthorizationAlter showAuthorizationAlertWithTitle:content] ;
            return NO ;
        }
    }else{
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"设备不支持相机" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
        [alter show] ;
        return NO ;
    }
    return YES ;
}

@end

#pragma clang diagnostic pop
