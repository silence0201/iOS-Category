//
//  UITextField+InputLimit.m
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UITextField+InputLimit.h"
#import <objc/runtime.h>

static const void *SITextFieldInputLimitMaxLength = &SITextFieldInputLimitMaxLength;
@implementation UITextField (InputLimit)

- (NSInteger)maxLength {
    return [objc_getAssociatedObject(self, SITextFieldInputLimitMaxLength) integerValue];
}
- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, SITextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.maxLength > 0 && toBeString.length > self.maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}


@end
