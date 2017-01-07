//
//  UIImage+Effect.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Effect)

- (nullable UIImage *)imageByTintColor:(UIColor *)color;

- (nullable UIImage *)imageByGrayscale;
- (nullable UIImage *)imageByBlurSoft;
- (nullable UIImage *)imageByBlurLight;
- (nullable UIImage *)imageByBlurExtraLight;
- (nullable UIImage *)imageByBlurDark;
- (nullable UIImage *)imageByBlurWithTint:(UIColor *)tintColor;

- (nullable
   UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                              tintColor:(nullable UIColor *)tintColor
                               tintMode:(CGBlendMode)tintBlendMode
                             saturation:(CGFloat)saturation
                              maskImage:(nullable UIImage *)maskImage;

@end
