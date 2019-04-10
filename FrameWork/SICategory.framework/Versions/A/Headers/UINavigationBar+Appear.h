//
//  UINavigationBar+Appear.h
//  Category
//
//  Created by Silence on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Appear)

/// 隐藏阴影
- (void)hideBottomShadow;
/// 显示阴影
- (void)showBottomShadow;

/// 导航栏透明
- (void)makeTransparent;
/// 默认导航栏
- (void)makeDefault;

@end
