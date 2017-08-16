//
//  UIWebView+Load.m
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIWebView+Load.h"

@implementation UIWebView (Load)

- (void)loadURL:(NSString*)URLString{
    NSString *encodedUrl = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes (NULL, (__bridge CFStringRef) URLString, NULL, NULL,kCFStringEncodingUTF8);
    NSURL *url = [NSURL URLWithString:encodedUrl];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self loadRequest:req];
}

- (void)loadLocalHtml:(NSString*)htmlName{
    [self loadLocalHtml:htmlName inBundle:[NSBundle mainBundle]];
}

- (void)loadLocalHtml:(NSString*)htmlName inBundle:(NSBundle*)inBundle{
    NSString *filePath = [inBundle pathForResource:htmlName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

- (void)clearCookies{
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];
    [NSUserDefaults.standardUserDefaults synchronize];
}


@end
