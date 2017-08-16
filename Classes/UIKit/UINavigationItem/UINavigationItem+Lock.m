//
//  UINavigationItem+Lock.m
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UINavigationItem+Lock.h"

@implementation UINavigationItem (Lock)

- (void)lockRightItem:(BOOL)lock{
    NSArray *rightBarItems = self.rightBarButtonItems;
    if (rightBarItems  && [rightBarItems count]>0) {
        [rightBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIBarButtonItem class]] ||
                [obj isMemberOfClass:[UIBarButtonItem class]]){
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)obj;
                barButtonItem.enabled = !lock;
            }
        }];
    }
}

- (void)lockLeftItem:(BOOL)lock{
    NSArray *leftBarItems = self.leftBarButtonItems;
    if (leftBarItems  && [leftBarItems count]>0) {
        [leftBarItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIBarButtonItem class]] ||
                [obj isMemberOfClass:[UIBarButtonItem class]]){
                UIBarButtonItem *barButtonItem = (UIBarButtonItem *)obj;
                barButtonItem.enabled = !lock;
            }
        }];
    }
}


@end
