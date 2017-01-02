//
//  UIImage+Make.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Make)

+ (UIImage *)imageWithPDF:(id)dataOrPath ;
+ (UIImage *)imageWithPDF:(id)dataOrPath size:(CGSize)size;
+ (UIImage *)imageWithPDF:(id)dataOrPath resize:(BOOL)resize size:(CGSize)size ;

+ (UIImage *)imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

@end
