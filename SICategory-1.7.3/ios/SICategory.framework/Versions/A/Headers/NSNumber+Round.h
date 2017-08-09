//
//  NSNumber+Round.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Round)

/**
 *  @brief  四舍五入
 *  @param digit  限制最大位数
 *  @return 结果
 */
- (NSNumber*)roundWithDigit:(NSUInteger)digit;

/**
 *  @brief  取上整
 *  @param digit  限制最大位数
 *  @return 结果
 */
- (NSNumber*)ceilWithDigit:(NSUInteger)digit;

/**
 *  @brief  取下整
 *  @param digit  限制最大位数
 *  @return 结果
 */
- (NSNumber*)floorWithDigit:(NSUInteger)digit;

@end
