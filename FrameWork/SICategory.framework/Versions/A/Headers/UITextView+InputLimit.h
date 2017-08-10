//
//  UITextView+InputLimit.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (InputLimit)

@property (assign, nonatomic)  NSInteger maxLength;//if <=0, no limit

@end
