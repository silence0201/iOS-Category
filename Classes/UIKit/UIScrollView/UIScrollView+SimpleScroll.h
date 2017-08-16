//
//  UIScrollView+SimpleScroll.h
//  Category
//
//  Created by Silence on 04/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (SimpleScroll)

- (void)scrollToTop;
- (void)scrollToBottom;
- (void)scrollToLeft;
- (void)scrollToRight;

- (void)scrollToTopAnimated:(BOOL)animated;
- (void)scrollToBottomAnimated:(BOOL)animated;
- (void)scrollToLeftAnimated:(BOOL)animated;
- (void)scrollToRightAnimated:(BOOL)animated;

@end
