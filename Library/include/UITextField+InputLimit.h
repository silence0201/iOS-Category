//
//  UITextField+InputLimit.h
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (InputLimit)

@property (assign, nonatomic)  NSInteger maxLength ; // <= 0无限制

@end
