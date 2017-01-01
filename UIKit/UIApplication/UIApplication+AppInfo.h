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

- (NSString *)applicationSizeAsString;
- (int)applicationSizeSizeInBytes ;

- (NSString *)documentsFolderSizeAsString;
- (int)documentsFolderSizeInBytes;

- (NSString *)cacheFolderSizeAsString;
- (int)cacheFolderSizeInBytes;

- (NSString *)libraryFolderSizeAsString;
- (int)libraryFolderSizeInBytes;


@end
