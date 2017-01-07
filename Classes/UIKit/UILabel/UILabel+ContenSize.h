//
//  UILabel+ContenSize.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ContenSize)

- (CGSize)contentSizeForWidth:(CGFloat)width;
- (CGSize)contentSize;
- (BOOL)isTruncated;

@end
