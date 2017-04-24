//
//  NSDate+Show.m
//  Category
//
//  Created by 杨晴贺 on 2017/4/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSDate+Show.h"

@implementation NSDate (Show)

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    formatter.locale = [NSLocale currentLocale];
    return [formatter stringFromDate:self];
}

- (NSString *)shortString{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortTimeString{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)shortDateString{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)mediumString{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumTimeString{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)mediumDateString{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)longString{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longTimeString{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)longDateString{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}


- (NSString *)weekString {
    return [NSDate weekStringFromDate:self];
}

+ (NSString *)weekStringFromDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    switch(weekday) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (NSString *)monthString {
    return [NSDate monthStringFromDate:self] ;
}

+ (NSString *)monthStringFromDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger month = [comps month];
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}


- (NSString *)ymdFormat {
    return [self _stringWithFormat:[NSDate ymdFormat]];
}

+ (NSString *)ymdFormatWithDate:(NSDate *)date {
    return [date _stringWithFormat:[NSDate ymdFormat]];
}


- (NSString *)hmsFormat {
    return [self _stringWithFormat:[NSDate hmsFormat]];
}

+ (NSString *)hmsFormatWithDate:(NSDate *)date {
    return [date _stringWithFormat:[NSDate hmsFormat]];
}

- (NSString *)ymdHmsFormat {
    return [self _stringWithFormat:[NSDate ymdHmsFormat]];
}

+ (NSString *)ymdHmsFormatWithDate:(NSDate *)date {
    return [date _stringWithFormat:[NSDate ymdHmsFormat]];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

- (NSString *)_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSString *)chineseCalendarWithDate:(NSDate *)date{
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅",	@"丁卯",	@"戊辰",	@"己巳",	@"庚午",	@"辛未",	@"壬申",	@"癸酉",
                             @"甲戌",	@"乙亥",	@"丙子",	@"丁丑", @"戊寅",	@"己卯",	@"庚辰",	@"辛己",	@"壬午",	@"癸未",
                             @"甲申",	@"乙酉",	@"丙戌",	@"丁亥",	@"戊子",	@"己丑",	@"庚寅",	@"辛卯",	@"壬辰",	@"癸巳",
                             @"甲午",	@"乙未",	@"丙申",	@"丁酉",	@"戊戌",	@"己亥",	@"庚子",	@"辛丑",	@"壬寅",	@"癸丑",
                             @"甲辰",	@"乙巳",	@"丙午",	@"丁未",	@"戊申",	@"己酉",	@"庚戌",	@"辛亥",	@"壬子",	@"癸丑",
                             @"甲寅",	@"乙卯",	@"丙辰",	@"丁巳",	@"戊午",	@"己未",	@"庚申",	@"辛酉",	@"壬戌",	@"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    if(date){
        NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
        NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
        NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
        NSString *chineseCal_str =[NSString stringWithFormat: @"%@年%@%@",y_str,m_str,d_str];
        return chineseCal_str;
    }
    return @"请重选一次";
}

- (NSString *)chineseCalendar {
    return [NSDate chineseCalendarWithDate:self];
}




@end
