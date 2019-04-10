//
//  NSString+Append.h
//  Category
//
//  Created by Silence on 2017/12/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Append)

- (NSString *)appendHomePath;
- (NSString *)appendDocumentPath;
- (NSString *)appendCachePath;
- (NSString *)appendMainBundlePath;
- (NSString *)appendTempPath;
- (NSString *)appendPreferencesPath;

@end
