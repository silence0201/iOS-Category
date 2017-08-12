//
//  UISlider+Tap.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/12.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (Tap)

/// 单击手势,会自动到对应比例
- (void)addTapGestureWithTarget: (id)target action: (SEL)action;

@end
