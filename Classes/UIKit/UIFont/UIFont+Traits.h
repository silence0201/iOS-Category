//
//  UIFont+Traits.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Traits)

@property (nonatomic, readonly) BOOL isBold;
@property (nonatomic, readonly) BOOL isItalic;
@property (nonatomic, readonly) BOOL isMonoSpace;
@property (nonatomic, readonly) BOOL isColorGlyphs;
@property (nonatomic, readonly) CGFloat fontWeight;

@end
