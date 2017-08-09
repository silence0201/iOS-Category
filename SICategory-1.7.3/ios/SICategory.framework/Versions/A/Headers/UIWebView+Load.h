//
//  UIWebView+Load.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (Load)

/**
 *  @brief  读取一个网页地址
 *
 *  @param URLString 网页地址
 */
- (void)loadURL:(NSString*)URLString;
/**
 *  @brief  读取bundle中的webview
 *
 *  @param htmlName 文件名称 xxx.html
 */
- (void)loadLocalHtml:(NSString*)htmlName;
/**
 *
 *  读取bundle中的webview
 *
 *  @param htmlName htmlName 文件名称 xxx.html
 *  @param inBundle bundle
 */
- (void)loadLocalHtml:(NSString*)htmlName inBundle:(NSBundle*)inBundle;

/**
 *  @brief  清空cookie
 */
- (void)clearCookies;

@end
