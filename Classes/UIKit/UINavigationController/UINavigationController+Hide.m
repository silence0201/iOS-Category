//
//  UINavigationController+Hide.m
//  HIdeDemo
//
//  Created by Silence on 17/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "UINavigationController+Hide.h"

@implementation UINavigationController (Hide)

- (BOOL)isNavBarHidden{
    return self.navigationBar.frame.origin.y < 20 ;
}

- (void)setNavBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion {
    
    if ([self isNavBarHidden] == hidden)
        return (completion) ? completion(YES) : nil;
    
    CGRect frame = [[self navigationBar] frame];
    frame.origin.y = (hidden) ? -24 : 20;
    [UIView animateWithDuration:((animated) ? 0.3 : 0.0)
                     animations:^{
                         [[self navigationBar] setFrame:frame];
                     } completion:completion];
}

@end
