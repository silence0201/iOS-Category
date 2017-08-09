//
//  NSDate+Show.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Show)

#pragma mark ----short time 格式化的时间
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

/// 根据 date 获取 农历
- (NSString *)chineseCalendar ;
+ (NSString *)chineseCalendarWithDate:(NSDate *)date;

///使用dateStyle timeStyle格式化时间
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;


/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)weekString;
+ (NSString *)weekStringFromDate:(NSDate *)date;

/**
 *  Get the month as a localized string from the given month number
 
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
- (NSString *)monthString;
+ (NSString *)monthStringFromDate:(NSDate *)month;

/// 获取yyyy-MM-dd格式化时间字符串
- (NSString *)ymdFormat;
+ (NSString *)ymdFormatWithDate:(NSDate *)date;

/// 获取HH:mm:ss格式化时间字符串
- (NSString *)hmsFormat;
+ (NSString *)hmsFormatWithDate:(NSDate *)date;

/// 获取yyyy-MM-dd HH:mm:ss格式化时间字符串
- (NSString *)ymdHmsFormat;
+ (NSString *)ymdHmsFormatWithDate:(NSDate *)date;

/// 获取yyyy-MM-dd的字符串
+ (NSString *)ymdFormat;
/// 获取HH:mm:ss的字符串
+ (NSString *)hmsFormat;
/// 获取yyyy-MM-dd HH:mm:ss的字符串
+ (NSString *)ymdHmsFormat;


@end
