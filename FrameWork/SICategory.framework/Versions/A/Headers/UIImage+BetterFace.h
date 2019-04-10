//
//  UIImage+BetterFace.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Accuracy) {
    AccuracyLow = 0,
    AccuracyHigh,
};
@interface UIImage (BetterFace)

- (UIImage *)betterFaceImageForSize:(CGSize)size
                              accuracy:(Accuracy)accurary;

@end
