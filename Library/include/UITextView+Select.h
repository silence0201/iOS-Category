//
//  UITextView+Select.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Select)

/// 当前选中的字符串范围
- (NSRange)selectedRange;

/// 选中所有文字
- (void)selectAllText;

/// 选中指定范围的文字
- (void)setSelectedRange:(NSRange)range;

/// 用于计算textview输入情况下的字符数，解决实现限制字符数时，计算不准的问题
- (NSInteger)getInputLengthWithText:(NSString *)text;

@end
