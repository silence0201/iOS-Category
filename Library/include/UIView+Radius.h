//
//  UIView+IBnspectable.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

/** View的XIB可视化扩展类> */
@interface UIView (Radius)

/// 给UIView 设置圆角
@property (assign,nonatomic) NSInteger cornerRadius;
@property (assign,nonatomic) BOOL  masksToBounds;


///设置 view的 边框颜色(选择器和Hex颜色)以及 边框的宽度
@property (assign,nonatomic) NSInteger borderWidth;
@property (strong,nonatomic) UIColor  *borderColor;

- (void)setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

@end
