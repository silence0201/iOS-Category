//
//  UITextField+PlaceHolder.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/21.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UITextField+PlaceHolder.h"
#import <objc/runtime.h>

@implementation UITextField (PlaceHolder)

- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, @selector(placeHolderTextView));
}
- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, @selector(placeHolderTextView), placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)addPlaceHolder:(NSString *)placeHolder {
    if (![self placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    self.placeHolderTextView.text = placeHolder;
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
