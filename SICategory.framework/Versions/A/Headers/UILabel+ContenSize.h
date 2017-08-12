//
//  UILabel+ContenSize.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ContenSize)


/**
 Content的Size

 @param width 限制宽度
 @return Size
 */
- (CGSize)contentSizeForWidth:(CGFloat)width;


/**
 Content Size

 @return Size
 */
- (CGSize)contentSize;


/**
 是否被截断

 @return 是否被截断
 */
- (BOOL)isTruncated;

@end
