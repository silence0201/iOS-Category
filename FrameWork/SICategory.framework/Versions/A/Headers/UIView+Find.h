//
//  UIView+Find.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Find)

/// 找到指定类名的第一个subView
- (UIView *)findSubViewWithClass:(Class)clazz;

/// 找到指定类名的所有subview
- (NSArray *)findAllSubViewsWithClass:(Class)clazz;

/// 找到当前view所在的viewcontroler
- (UIViewController *)viewController;

/// 所有的子控件,包括子控件的子控件
- (NSArray *)allSubviews;

/// 移除所有的子控件
- (void)removeAllSubviews;

/// 找到view上的第一响应者
- (UIView *)findFirstResponder;

@end
