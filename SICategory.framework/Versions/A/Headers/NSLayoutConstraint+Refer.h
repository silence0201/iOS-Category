//
//  NSLayoutConstraint+Refer.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Refer)

// child-parent constraints
+ (NSLayoutConstraint*)centerXOfChild:(UIView*)child toCenterXOfParent:(UIView*)parent;
+ (NSLayoutConstraint*)centerXOfChild:(UIView*)child toCenterXOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin;
+ (NSLayoutConstraint*)centerYOfChild:(UIView*)child toCenterYOfParent:(UIView*)parent;
+ (NSLayoutConstraint*)centerYOfChild:(UIView*)child toCenterYOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin;
+ (NSArray*)centerOfChild:(UIView*)child toCenterOfParent:(UIView*)parent;

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toTopOfParent:(UIView*)parent;
+ (NSLayoutConstraint*)topOfChild:(UIView*)child toTopOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin;

+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toBottomOfParent:(UIView*)parent;
+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toBottomOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin;

+ (NSLayoutConstraint*)leftOfChild:(UIView*)child toLeftOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin;
+ (NSLayoutConstraint*)rightOfChild:(UIView*)child toRightOfParent:(UIView*)parent withFixedMargin:(CGFloat)margin;
+ (NSArray*)sidesOfChild:(UIView*)child toSidesOfParent:(UIView*)parent;
+ (NSArray*)sidesOfChild:(UIView*)child toSidesOfParent:(UIView*)parent margin:(CGFloat)margin;

+ (NSArray*)extentOfChild:(UIView*)child toExtentOfParent:(UIView*)parent;

// sibling constraints
+ (NSLayoutConstraint*)centerXOfChild:(UIView*)child toCenterXOfSibling:(UIView*)sibling inParent:(UIView*)parent;
+ (NSLayoutConstraint*)centerYOfChild:(UIView*)child toCenterYOfSibling:(UIView*)sibling inParent:(UIView*)parent;
+ (NSArray*)centerOfChild:(UIView*)child toCenterOfSibling:(UIView*)sibling inParent:(UIView*)parent;

+ (NSLayoutConstraint*)widthOfChild:(UIView*)child toWidthOfSibling:(UIView*)sibling inParent:(UIView*)parent;
+ (NSLayoutConstraint*)heightOfChild:(UIView*)child toHeightOfSibling:(UIView*)sibling inParent:(UIView*)parent;
+ (NSArray*)sizeOfChild:(UIView*)child toSizeOfSibling:(UIView*)sibling inParent:(UIView*)parent;

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toTopOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;
+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toBottomOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;
+ (NSLayoutConstraint*)leftOfChild:(UIView*)child toLeftOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;
+ (NSLayoutConstraint*)rightOfChild:(UIView*)child toRightOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;

+ (NSLayoutConstraint*)topOfChild:(UIView*)child toBottomOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;
+ (NSLayoutConstraint*)bottomOfChild:(UIView*)child toTopOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;
+ (NSLayoutConstraint*)leftOfChild:(UIView*)child toRightOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;
+ (NSLayoutConstraint*)rightOfChild:(UIView*)child toLeftOfSibling:(UIView*)sibling withFixedMargin:(CGFloat)margin inParent:(UIView*)parent;

+ (NSArray*)constrainExtentOfView:(UIView*)aView toSiblingView:(UIView*)anotherView withParent:(UIView*)parentView;


// internal constraints
+ (NSLayoutConstraint*)view:(UIView*)aView toFixedHeight:(CGFloat)height;
+ (NSLayoutConstraint*)view:(UIView*)aView toFixedWidth:(CGFloat)width;
+ (NSLayoutConstraint*)view:(UIView*)aView widthToMultipleOfHeight:(CGFloat)multiple;

@end
