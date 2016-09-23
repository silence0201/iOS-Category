//
//  UIColor+colorWithHexString.h
//  Category
//
//  Created by 杨晴贺 on 23/09/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (colorWithHexString)

+ (UIColor *)colorWithHexString:(NSString *)color ;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
