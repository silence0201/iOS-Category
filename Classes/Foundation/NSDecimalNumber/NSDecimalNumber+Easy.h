//
//  NSDecimalNumber+Easy.h
//  Category
//
//  Created by 杨晴贺 on 2018/1/18.
//  Copyright © 2018年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SICalculationType) {
    SICalculationAdd,
    SICalculationSubtract,
    SICalculationMultiply,
    SICalculationDivide
};

@interface NSDecimalNumber (Easy)

+ (NSDecimalNumber *)decimalNumber:(id)strOrNum
                      roundingMode:(NSRoundingMode)mode
                             scale:(int)scale;

+ (NSDecimalNumber *)decimalNumber:(id)stringOrNumber1
                              type:(SICalculationType)type
              anotherDecimalNumber:(id)stringOrNumber2
           andDecimalNumberHandler:(NSDecimalNumberHandler *)handler;

+ (NSComparisonResult)compare:(id)stringOrNumber1
         anotherDecimalNumber:(id)stringOrNumber2;

+ (NSDecimalNumber *)add:(id)stringOrNumber1 another:(id)stringOrNumber2;
+ (NSDecimalNumber *)sub:(id)stringOrNumber1 another:(id)stringOrNumber2;
+ (NSDecimalNumber *)mul:(id)stringOrNumber1 another:(id)stringOrNumber2;
+ (NSDecimalNumber *)div:(id)stringOrNumber1 another:(id)stringOrNumber2;

+ (NSDecimalNumber *)min:(id)stringOrNumber1 another:(id)stringOrNumber2;
+ (NSDecimalNumber *)max:(id)stringOrNumber1 another:(id)stringOrNumber2;

@end
