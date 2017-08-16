//
//  UIFont+Make.h
//  Category
//
//  Created by Silence on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (Make)

- (UIFont *)fontWithBold ;
- (UIFont *)fontWithItalic ;
- (UIFont *)fontWithBoldItalic ;
- (UIFont *)fontWithNormal ;

+ (UIFont *)fontWithCTFont:(CTFontRef)CTFont;
+ (UIFont *)fontWithCGFont:(CGFontRef)CGFont size:(CGFloat)size;

- (CTFontRef)CTFontRef ;
- (CGFontRef)CGFontRef ;


@end
