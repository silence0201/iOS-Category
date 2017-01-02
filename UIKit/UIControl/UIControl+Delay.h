//
//  UIControl+Delay.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Delay)

/// 每次响应的间隔
@property (assign, nonatomic) NSTimeInterval acceptEventInterval;

@end
