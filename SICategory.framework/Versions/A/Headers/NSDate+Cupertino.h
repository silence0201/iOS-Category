//
//  NSDate+Cupertino.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Cupertino)

- (NSDate *)beginningOfDay;
- (NSDate *)endOfDay;

- (NSDate *)beginningOfWeek;
- (NSDate *)endOfWeek;

- (NSDate *)beginningOfMonth;
- (NSDate *)endOfMonth;


- (NSDate *)beginningOfYear;
- (NSDate *)endOfYear;

@end
