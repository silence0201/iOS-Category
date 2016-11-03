//
//  NSData+CalendarExtension.h
//  Category
//
//  Created by 杨晴贺 on 03/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CalendarExtension)

#pragma mark -----------------------------------------------------------
/**
 当前月份的天数

 @return 天数
 */
- (NSInteger)numberOfDayInMonth ;

/**
 当前月份的周数
 
 @return 周数
 */
- (NSInteger)numberOfWeekInMoth ;

#pragma mark ------------------------------------------------------------
/**
 当前月第一天是礼拜几

 @return 礼拜
 */
- (NSInteger)weekOrdinality ;


/**
 当前月的第一天

 @return 第一天对象
 */
- (NSDate *)firstDayOfMonth ;


/**
 当前月的最后一天

 @return 最后一天的时间对象
 */
- (NSDate *)lastDayOfMonth ;

#pragma mark ---------------------------------------------------------------
/**
 获得当前时间之后的几个月

 @param month
 @return 时间对象
 */
- (NSDate *)followingMonth:(NSInteger)month ;


/**
  获得当前时间之后的几天

 @param day 天数
 @return 时间对象
 */
- (NSDate *)followingDay:(NSInteger)day ;

#pragma mark ---------------------------------------------------------------
/**
 获取年月日对象

 @return NSDateComponents
 */
- (NSDateComponents *)standerComponents ;

/**
 获取星期几  周日为1
 
 @return week的Int值
 */
- (NSInteger)getWeekWithDate ;


/**
 获取日期的描述
 
 @return 日期描述字符串
 */
- (NSString *)descriptionDateString ;

#pragma mark ---------------------------------------------------------------
/**
 NSString To NSDate

 @param dateString DateString
 @return Date
 */
+ (NSDate *)dateFromString:(NSString *)dateString ;


/**
 Date To String

 @param date Date
 @return String
 */
+ (NSString *)stringFromDate:(NSDate *)date ;


/**
 两者间的天数

 @param today 到那一天
 @param beforday 重那一天
 @return 天数
 */
+ (NSInteger)getDaytoDay:(NSDate *)today beforDay:(NSDate *)beforday ;


/**
 通过数字返回星期几

 @param week 整形值
 @return 星期描述
 */
+ (NSString *)getWeekStringFromInteger:(NSInteger)week ;

@end
