//
//  UINavigationController+Transitions.h
//  Category
//
//  Created by 杨晴贺 on 07/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Transitions)

/**
 Push With Transitions

 @param controller Controller
 @param transition Transitions
 */
- (void)pushViewController:(UIViewController *)controller withTransition:(UIViewAnimationTransition)transition;


/**
 Pop With Transitions

 @param transition Transitions
 @return Transitions
 */
- (UIViewController *)popViewControllerWithTransition:(UIViewAnimationTransition)transition;

@end
