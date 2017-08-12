//
//  UIWebView+JavaScript.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScript)

#pragma mark -
#pragma mark 获取网页中的数据
/// 获取某个标签的结点个数
- (int)nodeCountOfTag:(NSString *)tag;
/// 获取当前页面URL
- (NSString *)getCurrentURL;
/// 获取标题
- (NSString *)getTitle;
/// 获取图片
- (NSArray *)getImgs;
/// 获取当前页面所有链接
- (NSArray *)getOnClicks;
#pragma mark -
#pragma mark 改变网页样式和行为
/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)addClickEventOnImg;
/// 改变所有图像的宽度
- (void)setImgWidth:(int)size;
/// 改变所有图像的高度
- (void)setImgHeight:(int)size;
/// 改变指定标签的字体大小
- (void)setFontSize:(int) size withTag:(NSString *)tagName;

#pragma mark 删除
///根据 ElementsID 删除WebView 中的节点
- (void )deleteNodeByElementID:(NSString *)elementID;
/// 根据 ElementsClass 删除 WebView 中的节点
- (void )deleteNodeByElementClass:(NSString *)elementClass;
///根据  TagName 删除 WebView 的节点
- (void)deleteNodeByTagName:(NSString *)elementTagName;


@end
