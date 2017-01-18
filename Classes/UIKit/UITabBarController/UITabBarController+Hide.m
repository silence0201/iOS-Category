//
//  UITabBarController+Hide.m
//  HIdeDemo
//
//  Created by 杨晴贺 on 17/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "UITabBarController+Hide.h"

@implementation UITabBarController (Hide)

- (BOOL)isTabBarHidden {
    return [[self tabBar] frame].origin.y >= CGRectGetMaxY([[self view] frame]);
}

- (void)setTabBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion {
    
    if ([self isTabBarHidden] == hidden)
        return (completion) ? completion(YES) : nil;
    
    CGRect frame = [[self tabBar] frame];
    frame.origin.y = (hidden) ? [[self view] frame].size.height :[[self view] frame].size.height - frame.size.height;
    [UIView animateWithDuration:((animated) ? 0.3 : 0.0)
                     animations:^{
                         [[self tabBar] setFrame:frame];
                     } completion:completion];
}

@end
