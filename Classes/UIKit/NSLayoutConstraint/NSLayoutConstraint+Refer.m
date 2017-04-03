//
//  NSLayoutConstraint+Refer.m
//  Category
//
//  Created by 杨晴贺 on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSLayoutConstraint+Refer.h"

@implementation NSLayoutConstraint (Refer)

#pragma mark - private helpers

+ (NSLayoutConstraint*)attrOfChild:(UIView*)child toSameAttrOfParent:(UIView*)parent attr:(NSLayoutAttribute)attr constant:(CGFloat)constant {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:child attribute:attr relatedBy:NSLayoutRelationEqual toItem:parent attribute:attr multiplier:1.0 constant:constant];
    [parent addConstraint:constraint];
    return constraint;
}

+ (NSLayoutConstraint*)attrOfChild:(UIView*)child toSameAttrOfSibling:(UIView*)sibling inParent:(UIView*)parent attr:(NSLayoutAttribute)attr constant:(CGFloat)constant {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:child attribute:attr relatedBy:NSLayoutRelationEqual toItem:sibling attribute:attr multiplier:1.0 constant:constant];
    [parent addConstraint:constraint];
    return constraint;
}

+ (NSLayoutConstraint*)view:(UIView*)aView attr:(NSLayoutAttribute)attr toFixedValue:(CGFloat)constant {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:aView attribute:attr relatedBy:NSLayoutRelationEqual toItem:nil attribute:attr multiplier:1.0 constant:constant];
    [aView addConstraint:constraint];
    return constraint;
}

#pragma mark - child-parent constraints

+ (NSLayoutConstraint*)centerXOfChild:(UIView*)child toCenterXOfParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeCenterX constant:0.0];
}

+ (NSLayoutConstraint*)centerXOfChild:(UIView*)child toCenterXOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeCenterX constant:margin];
}

+ (NSLayoutConstraint*)centerYOfChild:(UIView*)child toCenterYOfParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeCenterY constant:0.0];
}

+ (NSLayoutConstraint*)centerYOfChild:(UIView*)child toCenterYOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeCenterY constant:margin];
}

+ (NSArray*)centerOfChild:(UIView*)child toCenterOfParent:(UIView*)parent {
    NSLayoutConstraint *xConstraint = [self centerXOfChild:child toCenterXOfParent:parent];
    NSLayoutConstraint *yConstraint = [self centerYOfChild:child toCenterYOfParent:parent];
    return @[xConstraint, yConstraint];
}

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toTopOfParent:(UIView*)parent {
    return [self topOfChild:child toTopOfParent:parent withFixedMargin:0.0];
}

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toTopOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeTop constant:margin];
}

+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toBottomOfParent:(UIView*)parent {
    return [self bottomOfChild:child toBottomOfParent:parent withFixedMargin:0.0];
}

+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toBottomOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeBottom constant:margin];
}

+ (NSLayoutConstraint*)leftOfChild:(UIView*)child toLeftOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeLeft constant:margin];
}

+ (NSLayoutConstraint*)rightOfChild:(UIView*)child toRightOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin {
    return [self attrOfChild:child toSameAttrOfParent:parent attr:NSLayoutAttributeRight constant:margin];
}

+ (NSArray*)sidesOfChild:(UIView*)child toSidesOfParent:(UIView*)parent {
    return [self sidesOfChild:child toSidesOfParent:parent margin:0.0];
}

+ (NSArray*)sidesOfChild:(UIView*)child toSidesOfParent:(UIView*)parent margin:(CGFloat)margin {
    NSLayoutConstraint *lConstraint = [self leftOfChild:child toLeftOfParent:parent withFixedMargin:margin];
    NSLayoutConstraint *rConstraint = [self rightOfChild:child toRightOfParent:parent withFixedMargin:-(margin)];
    return @[lConstraint, rConstraint];
}

+ (NSArray*)extentOfChild:(UIView*)child toExtentOfParent:(UIView*)parent {
    NSMutableArray *extentConstraints = [[self sidesOfChild:child toSidesOfParent:parent] mutableCopy];
    [extentConstraints addObject:[self topOfChild:child toTopOfParent:parent]];
    [extentConstraints addObject:[self bottomOfChild:child toBottomOfParent:parent]];
    return extentConstraints;
}

#pragma mark - sibling constraints
+ (NSLayoutConstraint*)centerXOfChild:(UIView*)child toCenterXOfSibling:(UIView*)sibling inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeCenterX constant:0.0];
}

+ (NSLayoutConstraint*)centerYOfChild:(UIView*)child toCenterYOfSibling:(UIView*)sibling inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeCenterY constant:0.0];
}

+ (NSArray*)centerOfChild:(UIView*)child toCenterOfSibling:(UIView*)sibling inParent:(UIView*)parent {
    NSLayoutConstraint *xConstraint = [self centerXOfChild:child toCenterXOfSibling:sibling inParent:parent];
    NSLayoutConstraint *yConstraint = [self centerYOfChild:child toCenterYOfSibling:sibling inParent:parent];
    return @[xConstraint, yConstraint];
}

+ (NSLayoutConstraint*)widthOfChild:(UIView*)child toWidthOfSibling:(UIView*)sibling inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeWidth constant:0.0];
}

+ (NSLayoutConstraint*)heightOfChild:(UIView*)child toHeightOfSibling:(UIView*)sibling inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeHeight constant:0.0];
}

+ (NSArray*)sizeOfChild:(UIView*)child toSizeOfSibling:(UIView*)sibling inParent:(UIView*)parent {
    NSLayoutConstraint *wConstraint = [self widthOfChild:child toWidthOfSibling:sibling inParent:parent];
    NSLayoutConstraint *hConstraint = [self heightOfChild:child toHeightOfSibling:sibling inParent:parent];
    return @[wConstraint, hConstraint];
}

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toTopOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeTop constant:margin];
}

+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toBottomOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeBottom constant:margin];
}

+ (NSLayoutConstraint*)leftOfChild:(UIView*)child toLeftOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeLeft constant:margin];
}

+ (NSLayoutConstraint*)rightOfChild:(UIView*)child toRightOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    return [self attrOfChild:child toSameAttrOfSibling:sibling inParent:parent attr:NSLayoutAttributeRight constant:margin];
}

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toBottomOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:child attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:sibling attribute:NSLayoutAttributeBottom multiplier:1.0 constant:margin];
    [parent addConstraint:constraint];
    return constraint;
}

+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toTopOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:child attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:sibling attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    [parent addConstraint:constraint];
    return constraint;
}

+ (NSLayoutConstraint*)leftOfChild:(UIView*)child toRightOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:child attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:sibling attribute:NSLayoutAttributeRight multiplier:1.0 constant:margin];
    [parent addConstraint:constraint];
    return constraint;
}

+ (NSLayoutConstraint*)rightOfChild:(UIView*)child toLeftOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:child attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:sibling attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
    [parent addConstraint:constraint];
    return constraint;
}

+ (NSArray*)constrainExtentOfView:(UIView*)aView toSiblingView:(UIView*)anotherView withParent:(UIView*)parentView {
    NSLayoutConstraint *tConstraint = [self topOfChild:aView toTopOfSibling:anotherView withFixedMargin:0.0 inParent:parentView];
    NSLayoutConstraint *bConstraint = [self bottomOfChild:aView toBottomOfSibling:anotherView withFixedMargin:0.0 inParent:parentView];
    NSLayoutConstraint *lConstraint = [self leftOfChild:aView toLeftOfSibling:anotherView withFixedMargin:0.0 inParent:parentView];
    NSLayoutConstraint *rConstraint = [self rightOfChild:aView toRightOfSibling:anotherView withFixedMargin:0.0 inParent:parentView];
    return @[tConstraint, bConstraint, lConstraint, rConstraint];
}


#pragma mark - internal constraints

+ (NSLayoutConstraint*)view:(UIView*)aView toFixedHeight:(CGFloat)height {
    return [self view:aView attr:NSLayoutAttributeHeight toFixedValue:height];
}

+ (NSLayoutConstraint*)view:(UIView*)aView toFixedWidth:(CGFloat)width {
    return [self view:aView attr:NSLayoutAttributeWidth toFixedValue:width];
}

+ (NSLayoutConstraint*)view:(UIView*)aView widthToMultipleOfHeight:(CGFloat)multiple {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:aView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:aView attribute:NSLayoutAttributeHeight multiplier:multiple constant:0.0];
    [aView addConstraint:constraint];
    return constraint;
}

@end
