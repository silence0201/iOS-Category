//
//  UIScrollView+Frame.h
//  Category
//
//  Created by Silence on 2017/3/21.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Frame)

// Content Offset
@property (nonatomic) CGFloat contentOffsetX;
@property (nonatomic) CGFloat contentOffsetY;

// Content Size
@property (nonatomic) CGFloat contentSizeWidth;
@property (nonatomic) CGFloat contentSizeHeight;

// Content Inset
@property (nonatomic) CGFloat contentInsetTop;
@property (nonatomic) CGFloat contentInsetLeft;
@property (nonatomic) CGFloat contentInsetBottom;
@property (nonatomic) CGFloat contentInsetRight;

@end
