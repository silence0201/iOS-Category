//
//  UIView+Border.h
//  Category
//  https://github.com/cknessaj/UIView-Border
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 边框 */
typedef NS_OPTIONS(NSUInteger, UIViewBorderType) {
    UIViewBorderTypeLeft   = 1 << 0,
    UIViewBorderTypeRight  = 1 << 1,
    UIViewBorderTypeTop    = 1 << 2,
    UIViewBorderTypeBottom = 1 << 3,
    
    UIViewBorderTypeAll    = 1 << 4,
    
    UIViewBorderTypeNone   = 1 << 5
};


@interface NSBorderItem : NSObject

@property (nonatomic, assign) UIViewBorderType borderType;

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong ,nonnull) UIColor *borderColor;
@property (nonatomic, assign) CGLineCap lineCap;

@property (nonatomic, assign) CGFloat lineDashPhase;
@property (nonatomic, strong ,nullable) NSArray<NSNumber *> *lineDashPattern;

@end


@interface UIView (Border)
@property (nonatomic, assign) UIEdgeInsets borderEdge NS_AVAILABLE_IOS(6_0);
@property (nonatomic, assign) UIViewBorderType borderType NS_AVAILABLE_IOS(6_0);
@property (nonatomic, assign) CGFloat borderWidth NS_AVAILABLE_IOS(6_0);
@property (nonatomic, strong ,nonnull) UIColor *borderColor NS_AVAILABLE_IOS(6_0);

@property (nonatomic, strong ,nullable) NSArray<NSBorderItem *> *borderItems NS_AVAILABLE_IOS(6_0);

- (void)bringBorderViewToFront NS_AVAILABLE_IOS(6_0);
- (void)sendBorderViewToBack NS_AVAILABLE_IOS(6_0);

@end
