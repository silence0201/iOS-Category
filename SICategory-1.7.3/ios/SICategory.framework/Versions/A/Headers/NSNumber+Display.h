//
//  NSNumber+Display.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Display)

/// 显示指定精读
- (NSString *)displayNumberWithDigit:(NSInteger)digit;

/// 显示百分比
- (NSString *)displayPercentageWithDigit:(NSInteger)digit;

@end
