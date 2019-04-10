//
//  UIWebView+WebStorage.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (WebStorage)

#pragma mark - Local Storage

- (void)setLocalStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)localStorageStringForKey:(NSString *)key;

- (void)removeLocalStorageStringForKey:(NSString *)key;

- (void)clearLocalStorage;

#pragma mark - Session Storage

- (void)setSessionStorageString:(NSString *)string forKey:(NSString *)key;

- (NSString *)sessionStorageStringForKey:(NSString *)key;

- (void)removeSessionStorageStringForKey:(NSString *)key;

- (void)clearSessionStorage;

@end
