//
//  UIButton+ClickEdgeInsets.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 改变按钮的响应区域
@interface UIButton (ClickEdgeInsets)

/// 上左下右分别增加或减小多少  正数为增加 负数为减小
@property (nonatomic, assign) UIEdgeInsets clickEdgeInsets;

@end
