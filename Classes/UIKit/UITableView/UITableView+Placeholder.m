//
//  UITableView+Placeholder.m
//  Category
//
//  Created by Silence on 2017/12/20.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UITableView+Placeholder.h"
#import <objc/runtime.h>

#define force_inline __inline__ __attribute__((always_inline))

static force_inline void swizzMethod(SEL oriSel, SEL newSel) {
    Class class = [UITableView class];
    Method oriMethod = class_getInstanceMethod(class, oriSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    
    BOOL success = class_addMethod(class, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (success) {
        class_replaceMethod(class, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

@implementation UITableView (Placeholder)

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"si_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        swizzMethod(originalSelector, swizzledSelector);
    }
}

#pragma mark -- 替换方法
- (void)si_reloadData {
    [self showPlaceholderAction];
    [self si_reloadData];
}

- (void)si_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self showPlaceholderAction];
    [self si_insertSections:sections withRowAnimation:animation];
}

- (void)si_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self showPlaceholderAction];
    [self si_deleteSections:sections withRowAnimation:animation];
}

- (void)si_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self showPlaceholderAction];
    [self si_reloadSections:sections withRowAnimation:animation];
}

- (void)si_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self showPlaceholderAction];
    [self si_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)si_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self showPlaceholderAction];
    [self si_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)si_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self showPlaceholderAction];
    [self si_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)showPlaceholderAction{
    if (self.showPlaceholder) {
        NSInteger sectionCount = self.numberOfSections;
        NSInteger rowCount = 0;
        for (int i = 0; i < sectionCount; i++) {
            rowCount += [self.dataSource tableView:self numberOfRowsInSection:i];
        }
        if (rowCount == 0) {
            if (self.placeholderCustomView) {
                self.backgroundView = [self defaultCustomView];
            } else
                self.backgroundView = [self defaultNoDataView];
        } else {
            self.backgroundView = [[UIView alloc] init];
        }
    }
}

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

- (UIView *)noDataView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNoDataView:(UIView *)noDataView {
    objc_setAssociatedObject(self, @selector(noDataView), noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (UIView *)defaultCustomView {
    UIView *v = [[UIView alloc]initWithFrame:self.frame];
    self.placeholderCustomView.center = v.center;
    [v addSubview:self.placeholderCustomView];
    return v;
}

- (UIView *)defaultNoDataView {
    if (self.noDataView) return self.noDataView;
    self.noDataView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(si_tapDefalutNoDataView:)];
        [view addGestureRecognizer:tap];
        
        [view addSubview:[self placeholderImageView]];
        [view addSubview:[self placeholderLabel]];
        
        [self layoutDefaultView:view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
        view;
    });
    
    return self.defaultNoDataView;
}

- (void)layoutDefaultView:(UIView *)defaultView {
    UIImageView *imageView = [self placeholderImageView];
    UIImage *image = self.placeholderImage;
    imageView.image = image;
    CGFloat X = (self.bounds.size.width - image.size.width - self.contentInset.left - self.contentInset.right) / 2;
    CGFloat Y = (self.bounds.size.height - image.size.height - self.contentInset.top - self.contentInset.bottom) / 2 - 20;
    imageView.frame = CGRectMake(X, Y, image.size.width, image.size.height);
    
    UILabel *label = [self placeholderLabel];
    label.text = self.placeholderText;
    label.frame = CGRectMake(0, imageView.frame.origin.y + imageView.bounds.size.height + 10, self.bounds.size.width, 30);
}

- (void)si_tapDefalutNoDataView:(UITapGestureRecognizer *)tap {
    if (self.placeholderClickBlock) {
        self.placeholderClickBlock([self noDataView]);
    }
}

#pragma mark - notifications
- (void)onDeviceOrientationChange:(NSNotification *)noti {
    if (self.placeholderCustomView || !self.showPlaceholder) {
        return;
    }
    [self layoutDefaultView:self.defaultNoDataView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

