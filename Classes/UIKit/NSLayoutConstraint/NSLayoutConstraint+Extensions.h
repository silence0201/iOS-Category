//
//  NSLayoutConstraint+Extensions.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Extensions)

#pragma mark - Centering


/**
 @brief Creates constraints that align center of the view with the center of
 the reference view.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToCenterView:(UIView *)viewToCenter
                   withReferenceView:(UIView *)referenceView;


/**
 @brief Creates constraints that vertically align center of the view with
 the center of the reference view.
 */
+ (NSLayoutConstraint *)constraintsToCenterVerticallyView:(UIView *)viewToCenter
                                        withReferenceView:(UIView *)referenceView;


/**
 @brief Creates constraints that horizontally align center of the view with
 the center of the reference view.
 */
+ (NSLayoutConstraint *)constraintsToCenterHorizontallyView:(UIView *)viewToCenter
                                         withReferenceView:(UIView *)referenceView;


#pragma mark - Filling


/**
 @brief Creates constraints that horizontally fill the view with
 the second view.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToFillHorizontallyView:(UIView *)viewToFill
                                      withView:(UIView *)view;


/**
 @brief Creates constraints that horizontally fill the view with
 the second view leaving a padding on both sides.
 @param edgeInsets padding that should be applied when creating constraints.
 Only left and right values are used.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToFillHorizontallyView:(UIView *)viewToFill
                                      withView:(UIView *)view
                                    edgeInsets:(UIEdgeInsets)edgeInsets;


/**
 @brief Creates constraints that vertically fill the view with
 the second view.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToFillVerticallyView:(UIView *)viewToFill
                                    withView:(UIView *)view;


/**
 @brief Creates constraints that vertically fill the view with
 the second view leaving a top and bottom padding.
 @param edgeInsets padding that should be applied when creating constraints.
 Only top and bottom values are used.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToFillVerticallyView:(UIView *)viewToFill
                                    withView:(UIView *)view
                                  edgeInsets:(UIEdgeInsets)edgeInsets;


/**
 @brief Creates constraints that fill the view with the second view.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToFillView:(UIView *)viewToFill
                          withView:(UIView *)view;


/**
 @brief Creates constraints that fill the view with the second view.
 @param edgeInsets padding that should be applied when creating constraints.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToFillView:(UIView *)viewToFill
                          withView:(UIView *)view
                        edgeInsets:(UIEdgeInsets)edgeInsets;


#pragma mark - Setting width & height


/**
 @brief Creates constraint that pins width of the view.
 */
+ (NSLayoutConstraint *)constraintToSetWidth:(CGFloat)width
                                     forView:(UIView *)view;


/**
 @brief Creates constraint that pins height of the view.
 */
+ (NSLayoutConstraint *)constraintToSetHeight:(CGFloat)height
                                      forView:(UIView *)view;


/**
 @brief Creates constraint that pins width and height of the view.
 @returns Array of constraints.
 */
+ (NSArray *)constraintsToSetWidth:(CGFloat)width
                         andHeight:(CGFloat)height
                           forView:(UIView *)view;


@end
