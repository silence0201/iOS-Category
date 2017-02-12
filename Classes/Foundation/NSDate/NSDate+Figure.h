//
//  NSData+Figure.h
//  Category
//
//  Created by 杨晴贺 on 03/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Figure)

#pragma mark -----------------------------------------------------------
/**当前月份的天数*/
- (NSInteger)numberOfDayInMonth ;

/**当前月份的周数*/
- (NSInteger)numberOfWeekInMoth ;

#pragma mark ------------------------------------------------------------
/**当前月第一天是礼拜几*/
- (NSInteger)weekOrdinality ;

/**当前月的第一天*/
- (NSDate *)firstDayOfMonth ;

/** 当前月的最后一天*/
- (NSDate *)lastDayOfMonth ;

#pragma mark ---------------------------------------------------------------
/**获得当前时间之后的几秒*/
- (NSDate *)followingSecond:(NSInteger)second ;

/**获得当前时间之后的几分*/
- (NSDate *)followingMinute:(NSInteger)minute ;

/**获得当前时间之后的几小时*/
- (NSDate *)followingHour:(NSInteger)hour ;

/**获得当前时间之后的几天*/
- (NSDate *)followingDay:(NSInteger)day ;

/**获得当前时间之后的几周*/
- (NSDate *)followingWeek:(NSInteger)week ;

/**获得当前时间之后的几个月*/
- (NSDate *)followingMonth:(NSInteger)month ;

/**获得当前时间之后的几年*/
- (NSDate *)followingYear:(NSInteger)year ;

#pragma mark ---------------------------------------------------------------
/**获取年月日对象*/
- (NSDateComponents *)standerComponents ;

/** 获取星期几  周日为1*/
- (NSInteger)getWeekWithDate ;

/**获取日期的描述*/
- (NSString *)descriptionDateString ;

#pragma mark ---------------------------------------------------------------
/**NSString To NSDate*/
+ (NSDate *)dateFromString:(NSString *)dateString ;

/**Date To  String With Format*/
- (NSString *)stringWithFormat:(NSString *)format;

/**Date To String*/
+ (NSString *)stringFromDate:(NSDate *)date ;

/**两者间的天数*/
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday ;

/**通过数字返回星期几*/
+ (NSString *)getWeekStringFromInteger:(NSInteger)week ;

@end
