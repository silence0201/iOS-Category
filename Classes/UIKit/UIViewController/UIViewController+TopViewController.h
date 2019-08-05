//
//  UIViewController+TopViewController.h
//  Category
//
//  Created by Silence on 2019/8/5.
//  Copyright © 2019年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TopViewController)

- (UIViewController * _Nullable)topViewController;
- (void)presentViewControllerOnTopAnimated:(BOOL)flag completion:(void (^ _Nullable)(void))completion;

@end
