//
//  UIView+ViewPath.m
//  ViewPathDemo
//
//  Created by Silence on 2019/4/8.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "UIView+ViewPath.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation UIView (ViewPath)

-(BOOL)isRootView {
    UIResponder *nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return YES;
    }
    return NO;
}

- (NSString *)containerViewControllerName {
    UIView *tmpView = self;
    UIViewController *vc = nil;
    NSMutableString *conStr = [NSMutableString string];
    while (tmpView) {
        UIResponder *nextResponer = [tmpView nextResponder];
        if ([nextResponer isKindOfClass:[UIViewController class]]) {
            vc = (UIViewController *)nextResponer;
            break;
        }
        tmpView = tmpView.superview;
    }
    
    UITabBarController *tab = vc.tabBarController;
    UINavigationController *nav = vc.navigationController;
    
    if (tab) {
        NSInteger index = 0;
        for (UIViewController *viewController in tab.viewControllers) {
            if (viewController == nav || viewController == vc) break;
            index += 1;
        }
        [conStr appendFormat:@"%@[%ld]|",NSStringFromClass([tab class]),index];
    }
    
    if (nav) {
        NSInteger index = 0;
        for (UIViewController *viewController in nav.viewControllers) {
            if (viewController == vc) break;
            index += 1;
        }
        [conStr appendFormat:@"%@[%ld]|",NSStringFromClass([nav class]),index];
    }
    
    if (vc) {
        [conStr appendString:NSStringFromClass([vc class])];
    }
    
    return conStr;
}

- (NSString *)appendInfo {
    NSString *appendInfo = objc_getAssociatedObject(self, _cmd);
    if (!appendInfo) {
        // 自定义TableViewCell
        if ([self isMemberOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell *)self;
            appendInfo = cell.textLabel.text;
        }else if ([self isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)self;
            appendInfo = label.text;
        }else if ([self isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)self;
            appendInfo = btn.titleLabel.text;
        }
        objc_setAssociatedObject(self, _cmd, appendInfo, OBJC_ASSOCIATION_COPY);
    }
    return appendInfo;
}

- (NSString *)viewName {
    NSMutableString *viewName = objc_getAssociatedObject(self, _cmd);
    if (viewName) return viewName;
    viewName = [NSMutableString string];
    if ([self isRootView]) {
        NSString *strVcName = [self containerViewControllerName];
        if (strVcName) {
            [viewName appendFormat:@"%@|",strVcName];
        }
    }
    
    [viewName appendFormat:@"%@[%@]",NSStringFromClass(self.class),[self viewIndex]];
    if ([self appendInfo]) {
        [viewName appendFormat:@"+%@",[self appendInfo]];
    }
    
    objc_setAssociatedObject(self, _cmd, viewName, OBJC_ASSOCIATION_COPY);
    
    return viewName;
}

- (NSString *)viewIndex {
    NSString *strIndex = @"";
    if ([self isKindOfClass:[UITableViewCell class]] && [self.superview isKindOfClass:[UITableView class]]){
        UITableView *tableView = (UITableView *)self.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:(UITableViewCell *)self];
        strIndex = [NSString stringWithFormat:@"%ld,%ld",indexPath.section,indexPath.row];
    } else if ([self isKindOfClass:[UICollectionViewCell class]] && [self.superview isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.superview;
        NSIndexPath *indexPath = [collectionView indexPathForCell:(UICollectionViewCell *)self];
        strIndex = [NSString stringWithFormat:@"%ld:%ld",indexPath.section,indexPath.row];
    }else {
        NSInteger indexInSuper = 0;
        for (UIView *view in self.superview.subviews) {
            if ([view isKindOfClass:[self class]]) {
                if (view == self) break;
                indexInSuper += 1;
            }
        }
        strIndex = [NSString stringWithFormat:@"%ld",indexInSuper];
    }
    return strIndex;
}

- (NSString *)viewPath {
    NSString *viewPath = objc_getAssociatedObject(self, _cmd);
    if (viewPath) return viewPath;
    viewPath = [self viewName];
    UIView *view = self.superview;
    while (view) {
        NSString *viewName = [view viewName];
        viewPath = [NSString stringWithFormat:@"%@|%@",viewName,viewPath];
        
        if ([view isKindOfClass:[UIWindow class]]) break;
        view = view.superview;
    }
    
    objc_setAssociatedObject(self, _cmd, viewPath, OBJC_ASSOCIATION_COPY);
    
    return viewPath;
}

- (NSString *)viewID {
    NSString *viewPath = [self viewPath];
    const char *string = viewPath.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

@end
