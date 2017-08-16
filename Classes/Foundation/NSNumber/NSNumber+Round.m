//
//  NSNumber+Round.m
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSNumber+Round.h"

@implementation NSNumber (Round)

- (NSNumber*)roundWithDigit:(NSUInteger)digit{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:digit];
    [formatter setMinimumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber*)ceilWithDigit:(NSUInteger)digit{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

- (NSNumber*)floorWithDigit:(NSUInteger)digit{
    NSNumber *result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    [formatter setMaximumFractionDigits:digit];
    result = [NSNumber numberWithDouble:[[formatter  stringFromNumber:self] doubleValue]];
    return result;
}

@end
