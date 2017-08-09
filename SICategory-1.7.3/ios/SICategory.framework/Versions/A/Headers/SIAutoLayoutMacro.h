//
//  SIAutoLayoutMacro.h
//  Category
//
//  Created by 杨晴贺 on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

/// Creates a NSLayoutConstraint with a 1.0 multiplier and a constant of 0.
/// Use NSConstraintMakeWithConstant if you want to speficy a constant and multiplier.
#define NSConstraintMake(item, itemAttribute, related, otherItem, otherAttribute) \
NSConstraintMakeWithConstant(item, itemAttribute, related, otherItem, otherAttribute, 1.0, 0)

/// Use this macro if you want to add a constant or multiplier other than 0 or 1.0
#define NSConstraintMakeWithConstant(item, itemAttribute, related, otherItem, otherAttribute, mult, const) \
[NSLayoutConstraint constraintWithItem:item attribute:itemAttribute relatedBy:related toItem:otherItem attribute:otherAttribute multiplier:mult constant:const]

/// Makes the first item have a constraint equal to the second item.
#define NSConstraintMakeEqualTo(item, attribute, otherItem) \
NSConstraintMake(item, attribute, SIEqual, otherItem, attribute)

/// Makes the first item have a constraint equal to the second item, with the given offset.
#define NSConstraintMakeEqualToWithOffset(item, attribute, otherItem, offset) \
NSConstraintMakeWithConstant(item, attribute, SIEqual, otherItem, attribute, 1.0, offset)

/// Add a width constraint with a constant to the item.
#define NSConstraintMakeWidth(item, related, width) \
NSConstraintMakeWithConstant(item, SIWidth, related, nil, SINot, 1.0, width)

/// Make the width and height of the item equal.
/// Only use this when adding constraints to an array, as
/// this generates two constraints, it is not assignable to a single variable.
#define NSConstraintMakeWidthAndHeightEqual(item, size) \
NSConstraintMakeWithConstant(item, SIWidth, SIEqual, nil, SINot, 1.0, size), \
NSConstraintMakeWithConstant(item, SIHeight, SIEqual, item, SIWidth, 1.0, 0)

/// Add a height constraint with a constant to the item.
#define NSConstraintMakeHeight(item, related, height) \
NSConstraintMakeWithConstant(item, SIHeight, related, nil, SINot, 1.0, height)

/// Center the item within otherItem.
/// Only use this when adding constraints to an array, as
/// this generates two constraints, it is not assignable to a single variable.
#define NSConstraintMakeCenter(item, otherItem) \
NSConstraintMakeWithConstant(item, SICenterX, SIEqual, otherItem, SICenterX, 1.0, 0), \
NSConstraintMakeWithConstant(item, SICenterY, SIEqual, otherItem, SICenterY, 1.0, 0)

/// Center the item within otherItem, with the given offset.
/// Only use this when adding constraints to an array, as
/// this generates two constraints, it is not assignable to a single variable.
#define NSConstraintMakeCenterWithOffset(item, otherItem, offset) \
NSConstraintMakeWithConstant(item, SICenterX, SIEqual, otherItem, SICenterX, 1.0, offset), \
NSConstraintMakeWithConstant(item, SICenterY, SIEqual, otherItem, SICenterY, 1.0, offset)

#define SILeading NSLayoutAttributeLeading
#define SITrailing NSLayoutAttributeTrailing
#define SITop NSLayoutAttributeTop
#define SIBottom NSLayoutAttributeBottom
#define SICenterX NSLayoutAttributeCenterX
#define SICenterY NSLayoutAttributeCenterY
#define SILeft NSLayoutAttributeLeft
#define SIRight NSLayoutAttributeRight
#define SIBaseline NSLayoutAttributeBaseline
#define SIWidth NSLayoutAttributeWidth
#define SIHeight NSLayoutAttributeHeight
#define SINot NSLayoutAttributeNotAnAttribute
#define SIEqual NSLayoutRelationEqual
#define SIGreaterThanOrEqual NSLayoutRelationGreaterThanOrEqual
#define SILessThanOrEqual NSLayoutRelationLessThanOrEqual
