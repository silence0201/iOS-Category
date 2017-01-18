//
//  UINavigationController+Hide.h
//  HIdeDemo
//
//  Created by 杨晴贺 on 17/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Hide)

@property (nonatomic,getter=isNavBarHidden,readonly) BOOL navBarHidden ;

- (void)setNavBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion;

@end
