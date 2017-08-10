//
//  NSDateFormatter+Make.h
//  Category
//
//  Created by 杨晴贺 on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NSDateFormatterFormat) {
    NSDateFormatterFormatNone = 0,
    /**
     * Returns a basic formatter for a full date as four digit year, two digit month of year, and two digit day of month (yyyyMMdd).
     *  None: yyyyMMdd
     *  Time: yyyyMMdd'T'HHmmss.SSSZ
     *  NoMillis: yyyyMMdd'T'HHmmssZ
     */
    NSDateFormatterFormatBasic,
    /**
     *  Returns a formatter for a full ordinal date, using a four digit year and three digit dayOfYear (yyyyDDD).
     *  None: yyyyDDD
     *  Time: yyyyDDD'T'HHmmss.SSSZ
     *  NoMillis: yyyyDDD'T'HHmmssZ
     */
    NSDateFormatterFormatBasicOrdinalDate,
    /**
     *  Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit millis, and time zone offset (HHmmss.SSSZ).
     *  None/Time: HHmmss.SSSZ
     *  NoMillis: HHmmssZ
     */
    NSDateFormatterFormatBasicTime,
    /**
     * Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit millis, and time zone offset prefixed by 'T' ('T'HHmmss.SSSZ).
     *  None/Time: T'HHmmss.SSSZ
     *  NoMillis: T'HHmmss
     */
    NSDateFormatterFormatBasicTTime,
    /**
     * Returns a basic formatter for a full date as four digit weekyear, two digit week of weekyear, and one digit day of week (xxxx'W'wwe).
     *  None: xxxx'W'wwe
     *  Time: xxxx'W'wwe'T'HHmmss.SSSZ
     *  NoMillis: xxxx'W'wwe'T'HHmmssZ
     */
    NSDateFormatterFormatBasicWeekDate,
    /**
     * Returns a formatter for a full date as four digit year, two digit month of year, and two digit day of month (yyyy-MM-dd).
     *  None: yyyy-MM-dd
     *  Time: yyyy-MM-dd'T'HH:mm:ss.SSSZZ
     *  NoMillis: yyyy-MM-dd'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatDate,
    /**
     * Returns a formatter that combines a full date, two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (yyyy-MM-dd'T'HH:mm:ss.SSS).
     *  None/Time: yyyy-MM-dd'T'HH:mm:ss.SSS
     *  NoMillis: yyyy-MM-dd'T'HH:mm:ss
     */
    NSDateFormatterFormatDateHourMinuteSecondFraction,
    /**
     * Returns a formatter that combines a full date and time, separated by a 'T' (yyyy-MM-dd'T'HH:mm:ss.SSSZZ).
     *  None/Time: yyyy-MM-dd'T'HH:mm:ss.SSSZZ
     *  NoMillis: yyyy-MM-dd'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatDateTime,
    /**
     * Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (HH:mm:ss.SSS).
     *  None/Time: HH:mm:ss.SSS
     *  NoMillis: HH:mm:ss
     */
    NSDateFormatterFormatHourMinuteSecondFraction,
    /**
     * Returns a formatter for a full ordinal date, using a four digit year and three digit dayOfYear (yyyy-DDD).
     *  None: yyyy-MM-dd
     *  Time: yyyy-DDD'T'HH:mm:ss.SSSZZ
     *  NoMillis: yyyy-DDD'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatOrdinalDate,
    /**
     * Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit fraction of second, and time zone offset prefixed by 'T' ('T'HH:mm:ss.SSSZZ).
     *  None/Time: 'T'HH:mm:ss.SSSZZ
     *  NoMillis: 'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatTTime,
    /**
     * Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit fraction of second, and time zone offset (HH:mm:ss.SSSZZ).
     *  None/Time: HH:mm:ss.SSSZZ
     *  NoMillis: HH:mm:ssZZ
     */
    NSDateFormatterFormatTime,
    /**
     * Returns a formatter for a full date as four digit weekyear, two digit week of weekyear, and one digit day of week (xxxx-'W'ww-e).
     *  None: xxxx-'W'ww-e
     *  Time: xxxx-'W'ww-e'T'HH:mm:ss.SSSZZ
     *  NoMillis: xxxx-'W'ww-e'T'HH:mm:ssZZ
     */
    NSDateFormatterFormatWeekDate
};

typedef NS_ENUM(NSUInteger, NSDateFormatterTimeStyle) {
    NSDateFormatterTimeStyleNone = 0,
    NSDateFormatterTimeStyleTime,
    NSDateFormatterTimeStyleNoMillis
};

@interface NSDateFormatter (Make)

/**
 *
 *	Returns a `NSDateFormatter` with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *	@param timeStyle	NSDateFormatterFormat
 *
 *	@return NSDateFormatter instance
 */
+ (instancetype)dateFormatterWithDateFormat:(NSDateFormatterFormat)format timeStyle:(NSDateFormatterTimeStyle)timeStyle;


/**
 *
 *	Returns a `NSDateFormatter` with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyleNone` as `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *
 *	@return NSDateFormatter instance
 */
+ (instancetype)dateFormatterWithDateFormat:(NSDateFormatterFormat)format;

/**
 *
 *	Returns a string date format with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *	@param timeStyle	NSDateFormatterTimeStyle
 *
 *	@return NSString
 */
+ (NSString *)stringFormatForFormat:(NSDateFormatterFormat)format timeStyle:(NSDateFormatterTimeStyle)timeStyle;


/**
 *
 *	Returns a string date format with the specific `NSDateFormatterFormat` and `NSDateFormatterTimeStyleNone` as `NSDateFormatterTimeStyle`
 *
 *	@param format		NSDateFormatterFormat
 *
 *	@return NSString
 */
+ (NSString *)stringFormatForFormat:(NSDateFormatterFormat)format;

@end
