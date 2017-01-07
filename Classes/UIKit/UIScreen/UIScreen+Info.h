//
//  UIScreen+Info.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Info)

+ (BOOL)isRetina;
+ (CGFloat)screenScale;

+ (CGRect)screenBounds;
+ (CGRect)screenBoundsForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@property (nonatomic, readonly) CGSize sizeInPixel;
@property (nonatomic, readonly) CGFloat pixelsPerInch;

@end
