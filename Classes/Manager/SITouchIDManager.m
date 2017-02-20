//
//  SITouchIDManager.m
//  Category
//
//  Created by 杨晴贺 on 20/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SITouchIDManager.h"
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

NSInteger const kTouchIDErrorUnvailable = -100;
NSInteger const kTouchIDErrorUnAllow = -101;

@interface SITouchIDManager()

@property (nonatomic,strong) LAContext *authenticationContext;
@property (nonatomic,strong) NSError *lastError;

@end


@implementation SITouchIDManager

/// 单例
+ (instancetype)sharedManager{
    static SITouchIDManager *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init] ;
    });
    return manager ;
}

- (instancetype)init{
    if (self = [super init]) {
        self.authenticationContext = [[LAContext alloc]init] ;
    }
    return self ;
}

- (void)tryToPass{
    if(!self.isTouchIDAllowed){
        return ;
    }
    if (self.isTouchIDAvailable) {
        NSString *localizedReason = nil;
        localizedReason = self.alertDescription ;
        [self.authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                   localizedReason:localizedReason
                                             reply:^(BOOL success, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                if (success) {
                                    if(self.passSuccessBlock){
                                        self.passSuccessBlock(self) ;
                                    }
                                } else {
                                    [self sendFailWithError:error];
                                }
                            });
         }];
    }else {
        NSString *errorText = @"TouchID unavailable for inknown reason";
        NSError *error = [NSError errorWithDomain:@"TouchID domain"
                                             code:kTouchIDErrorUnvailable
                                         userInfo:@{errorText:NSLocalizedDescriptionKey}];
        [self sendFailWithError:error];
    }
}

- (BOOL)isTouchIDAvailable {
    NSError *error = nil;
    BOOL canEvaluatePolicyBiometrics = [self.authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (canEvaluatePolicyBiometrics) {
        return YES;
    }else {
        [self sendFailWithError:error];
        return NO;
    }
}

- (BOOL)isTouchIDAllowed {
    BOOL isTouchIDAllowed = YES;
    if(self.touchIDAllowBlock){
        self.touchIDAllowBlock(self) ;
    }
    if (!isTouchIDAllowed) {
        NSString *errorText = [NSString stringWithFormat:@"TouchID Not Allow in Block"];
        NSError *error = [NSError errorWithDomain:@"TouchID domain"
                                             code:kTouchIDErrorUnAllow
                                         userInfo:@{errorText :NSLocalizedDescriptionKey}];
        [self sendFailWithError:error];
    }
    return isTouchIDAllowed;
}


#pragma mark - Helpers
- (void)sendFailWithError: (NSError *)error {
    if (![self errorDidSend:error]) {
        if(self.passFailBlock){
            self.passFailBlock(self,error) ;
        }
        self.lastError = nil;
    }
}

- (BOOL)errorDidSend:(NSError *)error {
    if (self.lastError.code == error.code) {
        return YES;
    }
    self.lastError = error;
    return NO;
}

@end
