//
//  SIAppVersionManager.m
//  Category
//
//  Created by Silence on 24/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "SIAppVersionManager.h"
#import <UIKit/UIKit.h>

#define kCheckAppVersionTag 1001
@interface SIAppVersionManager ()<UIAlertViewDelegate>

@property (nonatomic,copy) NSString *appId;

@end

@implementation SIAppVersionManager

+ (SIAppVersionManager *)sharedManager{
    static SIAppVersionManager *manager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SIAppVersionManager alloc]init] ;
    });
    return manager ;
}

- (void)checkVersionWithAppID:(NSString *)appID showNewestMsg:(BOOL)showMsg{
    if ([self isAppId:appID]) {
        [self setAppId:appID];
        
        NSString *urlPath = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", appID];
        NSURL *url = [NSURL URLWithString:urlPath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        __weak SIAppVersionManager *weakSelf = self;
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if ([data length]>0 && !error ) {
                NSDictionary *appInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSDictionary *result = nil;
                NSArray *results = [appInfo valueForKey:@"results"];
                if (results != nil && results.count > 0) {
                    result = [results objectAtIndex:0];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *versionsInAppStore = [result valueForKey:@"version"];
                    if (versionsInAppStore) {
                        NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                        if ([bundleVersion compare:versionsInAppStore options:NSNumericSearch] == NSOrderedAscending) {
                            [weakSelf showAlertWithAppStoreVersion:versionsInAppStore
                                                           appleID:appID
                                                       description:[result valueForKey:@"description"]
                                                        updateInfo:[result valueForKey:@"releaseNotes"]];
                        }else if (showMsg){
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                message:@"当前应用已为最新版本"
                                                                               delegate:weakSelf
                                                                      cancelButtonTitle:@"好的"
                                                                      otherButtonTitles:nil];
                            [alertView show];
                        }
                    }
                });
            }
        }];
    }
}

- (void)showAlertWithAppStoreVersion:(NSString *)appStoreVersion appleID:(NSString *)appleID description:(NSString *)description updateInfo:(NSString *)updateInfo {
    NSString *message = [NSString stringWithFormat:@"%@\n%@",@"更新内容:", updateInfo];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"当前应用有新版本可以下载，是否前往更新？"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"更新", nil];
    [alertView setTag:kCheckAppVersionTag];
    [alertView show];
}

#pragma mark --- Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kCheckAppVersionTag) {
        switch ( buttonIndex ) {
            case 1:{
                NSString *urlPath = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", self.appId];
                NSURL *url = [NSURL URLWithString:urlPath];
                [[UIApplication sharedApplication] openURL:url];
            }
                break;
            default:
                break;
        }
    }
}


- (BOOL)isAppId:(NSString *)appID{
    return appID != nil && [appID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0 ;
}

@end
