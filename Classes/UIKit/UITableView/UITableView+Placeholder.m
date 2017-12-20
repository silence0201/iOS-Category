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
- (void)setShowNoData:(BOOL)showPlaceholder {
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

@end
