//
//  UIScreen+Info.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Info)

+ (BOOL)isRetina;   /// 是否是Retina屏幕
+ (CGFloat)screenScale;   /// 屏幕缩放比例

+ (CGRect)screenBounds;  /// 屏幕的bounds

/**
 屏幕的Bounds

 @param interfaceOrientation interfaceOrientation
 @return Bounds
 */
+ (CGRect)screenBoundsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@property (nonatomic, readonly) CGSize sizeInPixel;
@property (nonatomic, readonly) CGFloat pixelsPerInch;

@end
