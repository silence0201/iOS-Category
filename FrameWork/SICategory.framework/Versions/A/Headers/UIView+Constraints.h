//
//  UIView+Constraints.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraints)

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute;

- (NSLayoutConstraint *)leftConstraint;
- (NSLayoutConstraint *)rightConstraint;
- (NSLayoutConstraint *)topConstraint;
- (NSLayoutConstraint *)bottomConstraint;
- (NSLayoutConstraint *)leadingConstraint;
- (NSLayoutConstraint *)trailingConstraint;
- (NSLayoutConstraint *)widthConstraint;
- (NSLayoutConstraint *)heightConstraint;
- (NSLayoutConstraint *)centerXConstraint;
- (NSLayoutConstraint *)centerYConstraint;
- (NSLayoutConstraint *)baseLineConstraint;

@end
