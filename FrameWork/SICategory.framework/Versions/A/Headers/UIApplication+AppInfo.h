//
//  UIApplication+AppInfo.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AppInfo)

@property (nonatomic,readonly) NSString *appName ;
@property (nonatomic,readonly) NSString *appVersion ;
@property (nonatomic,readonly) NSString *appBuild ;
@property (nonatomic,readonly) NSString *appBundleID ;

/// applicationSize
- (NSString *)applicationSizeAsString;
- (int)applicationSizeSizeInBytes ;

/// documentsFolderSize
- (NSString *)documentsFolderSizeAsString;
- (int)documentsFolderSizeInBytes;

/// cacheFolderSize
- (NSString *)cacheFolderSizeAsString;
- (int)cacheFolderSizeInBytes;

/// libraryFolderSize
- (NSString *)libraryFolderSizeAsString;
- (int)libraryFolderSizeInBytes;

+ (BOOL)isAppExtension;
+ (UIApplication *)sharedExtensionApplication;


@end
