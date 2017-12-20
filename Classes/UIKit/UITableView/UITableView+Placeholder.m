//
//  UITableView+Placeholder.m
//  Category
//
//  Created by Silence on 2017/12/20.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UITableView+Placeholder.h"
#import <objc/runtime.h>

@implementation UITableView (Placeholder)

#pragma mark - setter && getter
- (void)setShowPlaceholder:(BOOL)showPlaceholder {
    objc_setAssociatedObject(self, @selector(showPlaceholder), @(showPlaceholder), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showPlaceholder {
    return objc_getAssociatedObject(self, _cmd) == nil ? YES : [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPlaceholderClickBlock:(PlaceholderClickBlock)placeholderClickBlock {
    objc_setAssociatedObject(self, @selector(placeholderClickBlock), placeholderClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (PlaceholderClickBlock)placeholderClickBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceholderCustomView:(UIView *)placeholderCustomView {
    objc_setAssociatedObject(self, @selector(placeholderCustomView), placeholderCustomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)placeholderCustomView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    objc_setAssociatedObject(self, @selector(placeholderText), placeholderText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)placeholderText {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    objc_setAssociatedObject(self, @selector(placeholderImage), placeholderImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)placeholderImage {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark -- View
- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, _cmd);
    if (!label) {
        label = [[UILabel alloc] init];
        label.text = self.placeholderText ? : @"暂无数据,点击刷新";
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        objc_setAssociatedObject(self, _cmd, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

- (UIImageView *)placeholderImageView {
    UIImageView *imageView = objc_getAssociatedObject(self, _cmd);
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.image = self.placeholderImage;
        imageView.contentMode = UIViewContentModeCenter;
        objc_setAssociatedObject(self, _cmd, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return imageView;
}

@end
