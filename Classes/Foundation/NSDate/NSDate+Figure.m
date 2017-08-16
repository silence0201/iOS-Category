//
//  NSData+Figure.m
//  Category
//
//  Created by Silence on 03/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSDate+Figure.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation NSDate (Figure)

// 计算这个月有多少天
- (NSInteger)numberOfDayInMonth{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}

// 计算第一天礼拜几
- (NSInteger)weekOrdinality{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self] ;
}

// 计算这个月最开始的一天
- (NSDate *)firstDayOfMonth{
    NSDate *startDate = nil ;
    [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self] ;
    return startDate ;
}

// 计算这个月最后的一天
- (NSDate *)lastDayOfMonth{
    NSCalendarUnit calendarUnit = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self] ;
    dateComponents.day = [self numberOfDayInMonth] ;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents] ;
}

// 获取当前日期之后的几秒的日期
- (NSDate *)followingSecond:(NSInteger)second{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + second;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
// 获取当前日期之后的几分的日期
- (NSDate *)followingMinute:(NSInteger)minute{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minute;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}
// 获取当前日期之后的几小时的日期
- (NSDate *)followingHour:(NSInteger)hour{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hour;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

// 获得当前日期之后的几天日期
- (NSDate *)followingDay:(NSInteger)day{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = day;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 获得当前日期之后的几周日期
- (NSDate *)followingWeek:(NSInteger)week{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:week];
    return [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
}

// 获取当前日期之后的几个月的日期
- (NSDate *)followingMonth:(NSInteger)month {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = month;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 获取当前日期之后的几年的日期
- (NSDate *)followingYear:(NSInteger)year{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = year;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}



- (NSDateComponents *)standerComponents{
    return [[NSCalendar currentCalendar] components:
            NSYearCalendarUnit|
            NSMonthCalendarUnit|
            NSDayCalendarUnit|
            NSWeekdayCalendarUnit fromDate:self];
}

// 计算当前月有多少周
- (NSInteger)numberOfWeekInMoth{
    NSUInteger weekday = [[self firstDayOfMonth] weekOrdinality];
    NSUInteger days = [self numberOfDayInMonth];
    NSUInteger weeks = 0;
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    return weeks;
}

// 星期几  周日为1
- (NSInteger)getWeekWithDate {
    NSInteger weekIntValue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit |
                                                   NSMonthCalendarUnit |
                                                   NSDayCalendarUnit |
                                                   NSWeekdayCalendarUnit) fromDate:self];
    return weekIntValue = [comps weekday];
}

// 判断日期是今天,明天,后天,周几
- (NSString *)descriptionDateString {
    NSDate *todate = [NSDate date];//今天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:todate];
    
    
    NSDateComponents *comps_other= [calendar components:(NSYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit) fromDate:self];
    
    
    //获取星期对应的数字
    NSInteger weekIntValue = [self getWeekWithDate];
    
    if (comps_today.year == comps_other.year &&
        comps_today.month == comps_other.month &&
        comps_today.day == comps_other.day) {
        return @"今天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -1){
        return @"明天";
        
    }else if (comps_today.year == comps_other.year &&
              comps_today.month == comps_other.month &&
              (comps_today.day - comps_other.day) == -2){
        return @"后天";
        
    }else{
        //直接返回当时日期的字符串(这里让它返回空)
        return [NSDate getWeekStringFromInteger:weekIntValue];//周几
    }
}


#pragma mark ---- Class Method
- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}
// NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

//  NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

// 两个日历之间相差多少天
+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:today toDate:beforday options:0];
    NSInteger day = [components day];
    return day;
}

// 通过数字返回星期几
+ (NSString *)getWeekStringFromInteger:(NSInteger)week {
    NSString *str_week;
    switch (week) {
        case 1:
            str_week = @"周日";
            break;
        case 2:
            str_week = @"周一";
            break;
        case 3:
            str_week = @"周二";
            break;
        case 4:
            str_week = @"周三";
            break;
        case 5:
            str_week = @"周四";
            break;
        case 6:
            str_week = @"周五";
            break;
        case 7:
            str_week = @"周六";
            break;
    }
    return str_week;
}

/**
 *  计算上次日期距离现在多久
 *  @param lastTime   上次日期(需要和格式对应)
 *  @param format1   上次日期格式
 *  @param currentTime 最近日期(需要和格式对应)
 *  @param format2   最近日期格式
 *  @return xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSString *)lastTime
                        lastTimeFormat:(NSString *)format1
                         ToCurrentTime:(NSString *)currentTime
                     currentTimeFormat:(NSString *)format2{
    
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *lastDate = [dateFormatter1 dateFromString:lastTime];
    
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *currentDate = [dateFormatter2 dateFromString:currentTime];
    return [NSDate timeIntervalFromLastTime:lastDate ToCurrentTime:currentDate];
}

/**
 计算两段时间间隔多久
 返回 多少多少 分钟
 */
+ (NSInteger) calculateTimeFromLastTime:(NSString *)lastTime
                          lasTimeFormat:(NSString *)format1
                          toCurrentTime:(NSString *)currentTime
                      currentTimeFormat:(NSString *)format2{
    //上次时间
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    dateFormatter1.dateFormat = format1;
    NSDate *last = [dateFormatter1 dateFromString:lastTime];
    
    //当前时间
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    dateFormatter2.dateFormat = format2;
    NSDate *current = [dateFormatter2 dateFromString:currentTime];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    
    //上次时间
    NSDate *lastDate = [last dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:last]];
    //当前时间
    NSDate *currentDate = [current dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:current]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    return intevalTime;
}

+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    //秒、分、小时、天、月、年
    NSInteger second = intevalTime;
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    if(second < 60){
        return [NSString stringWithFormat:@"%ld秒前", (long)second];
    }
    if (minutes <= 10) {
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

@end
#pragma clang diagnostic pop
