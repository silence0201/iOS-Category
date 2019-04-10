//
//  NSDate+Formatter.h
//  Category
//
//  Created by Silence on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

/// 默认格式信息对象
+(NSDateFormatter *)formatter;
/// 不带时间进行格式化对象
+(NSDateFormatter *)formatterWithoutTime;
/// 不带日期进行格式化对象
+(NSDateFormatter *)formatterWithoutDate;

/// UTCTimeZone
-(NSString *)formatWithUTCTimeZone;
/// LocalTimeZone
-(NSString *)formatWithLocalTimeZone;

/**
 TimeZoneOffset

 @param offset offset
 @return String
 */
-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
/// formatWithTimeZone
-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCTimeZoneWithoutTime;
-(NSString *)formatWithLocalTimeZoneWithoutTime;
-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCWithoutDate;
-(NSString *)formatWithLocalTimeWithoutDate;
-(NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;

+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;

+ (NSString *)currentDateStringWithFormat:(NSString *)format;
- (NSString *)dateWithFormat:(NSString *)format;

@end
