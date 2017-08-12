//
//  NSDate+Extension.h
//  Category
//
//  Created by 杨晴贺 on 10/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component

/** 时间戳 */
@property (nonatomic,copy,readonly) NSString *timestamp;
/** 时间成分 */
@property (nonatomic,strong,readonly) NSDateComponents *components;
/** 是否是今年*/
@property (nonatomic,assign,readonly) BOOL isThisYear;
/** 是否是今天 */
@property (nonatomic,assign,readonly) BOOL isToday;
/** 是否是昨天*/
@property (nonatomic,assign,readonly) BOOL isYesterday;
/** 是否是明天 */
@property (nonatomic,assign,readonly) BOOL isTomorrow;
/** 是否是一分钟 */
@property (nonatomic,assign,readonly) BOOL isInOneMinute;
/** 是否是一小时*/
@property (nonatomic,assign,readonly) BOOL isInOneHour;
/**
 *  两个时间比较
 *
 *  @param unit     成分单元
 *  @param fromDate 起点时间
 *  @param toDate   终点时间
 *  @return 时间成分对象
 */
+(NSDateComponents *)dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
