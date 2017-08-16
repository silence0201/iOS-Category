//
//  UIView+Badge.h
//  Category
//  From: https://github.com/weng1250/WZLBadge
//  Created by Silence on 2017/7/16.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WBadgeStyle){
    WBadgeStyleRedDot = 0,          /* red dot style */
    WBadgeStyleNumber,              /* badge with number */
    WBadgeStyleNew                  /* badge with a fixed text "new" */
};

typedef NS_ENUM(NSUInteger, WBadgeAnimType){
    WBadgeAnimTypeNone = 0,         /* without animation, badge stays still */
    WBadgeAnimTypeScale,            /* scale effect */
    WBadgeAnimTypeShake,            /* shaking effect */
    WBadgeAnimTypeBounce,           /* bouncing effect */
    WBadgeAnimTypeBreathe           /* breathing light effect, which makes badge more attractive */
};

@interface UIView (Badge)

@property (nonatomic, strong) UILabel *badge;
@property (nonatomic, strong) UIFont *badgeFont;
@property (nonatomic, strong) UIColor *badgeBgColor;
@property (nonatomic, strong) UIColor *badgeTextColor;
@property (nonatomic, assign) CGRect badgeFrame;

@property (nonatomic, assign) CGPoint  badgeCenterOffset;

@property (nonatomic, assign) WBadgeAnimType aniType;

@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;

@property (nonatomic, assign) CGFloat badgeRadius;

- (void)showBadge;

- (void)showBadgeWithStyle:(WBadgeStyle)style
                     value:(NSInteger)value
             animationType:(WBadgeAnimType)aniType;

- (void)showNumberBadgeWithValue:(NSInteger)value
                   animationType:(WBadgeAnimType)aniType;

- (void)showNumberBadgeWithValue:(NSInteger)value;

- (void)clearBadge;
- (void)resumeBadge;

@end
