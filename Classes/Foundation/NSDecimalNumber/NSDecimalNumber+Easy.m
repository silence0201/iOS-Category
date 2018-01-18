//
//  NSDecimalNumber+Easy.m
//  Category
//
//  Created by 杨晴贺 on 2018/1/18.
//  Copyright © 2018年 silence. All rights reserved.
//

#import "NSDecimalNumber+Easy.h"

@implementation NSDecimalNumber (Easy)

+ (NSDecimalNumber *)decimalNumber:(id)strOrNum
                      roundingMode:(NSRoundingMode)mode
                             scale:(int)scale {
    if (!strOrNum) return nil;
    NSDecimalNumber *one;
    if ([strOrNum isKindOfClass:[NSString class]]) {
        one = [NSDecimalNumber decimalNumberWithString:strOrNum];
    }else if([strOrNum isKindOfClass:[NSDecimalNumber class]]){
        one = strOrNum;
    }else if ([strOrNum isKindOfClass:[NSNumber class]]){
        one = [NSDecimalNumber decimalNumberWithDecimal:[strOrNum decimalValue]];
    }else{
        return nil;
    }
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:mode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    return  [one decimalNumberByRoundingAccordingToBehavior:handler];
}


+ (NSDecimalNumber *)decimalNumber:(id)stringOrNumber1
                              type:(SICalculationType)type
              anotherDecimalNumber:(id)stringOrNumber2
           andDecimalNumberHandler:(NSDecimalNumberHandler *)handler {
    if (!stringOrNumber2 || !stringOrNumber1) return nil;
    NSDecimalNumber *one;
    NSDecimalNumber *another;
    NSDecimalNumber *returnNum;
    if ([stringOrNumber1 isKindOfClass:[NSString class]]) {
        one = [NSDecimalNumber decimalNumberWithString:stringOrNumber1];
    }else if([stringOrNumber1 isKindOfClass:[NSDecimalNumber class]]){
        one = stringOrNumber1;
    }else if ([stringOrNumber1 isKindOfClass:[NSNumber class]]){
        one = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber1 decimalValue]];
    }else{
        return nil;
    }
    
    if ([stringOrNumber2 isKindOfClass:[NSString class]]) {
        another = [NSDecimalNumber decimalNumberWithString:stringOrNumber2];
    }else if([stringOrNumber2 isKindOfClass:[NSDecimalNumber class]]){
        another = stringOrNumber2;
    }else if ([stringOrNumber2 isKindOfClass:[NSNumber class]]){
        another = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber2 decimalValue]];
    }else{
        return nil;
    }
    if (type == SICalculationAdd) {
        returnNum = [one decimalNumberByAdding:another];
    }else if (type == SICalculationSubtract){
        returnNum  = [one decimalNumberBySubtracting:another];
    }else if (type == SICalculationMultiply){
        returnNum = [one decimalNumberByMultiplyingBy:another];
    }else if (type == SICalculationDivide){
        if ([NSDecimalNumber compare:another anotherDecimalNumber:@(0)] == 0) {
            returnNum = nil;
        }else {
            returnNum = [one decimalNumberByDividingBy:another];
        }
    }else{
        returnNum = nil;
    }
    if (returnNum) {
        if (handler) {
            return [returnNum decimalNumberByRoundingAccordingToBehavior:handler];
        }else{
            return returnNum;
        }
    }else{
        return nil;
    }
}

+ (NSComparisonResult)compare:(id)stringOrNumber1 anotherDecimalNumber:(id)stringOrNumber2 {
    if (!stringOrNumber2 || !stringOrNumber1) return -404;
    NSDecimalNumber *one;
    NSDecimalNumber *another;
    if ([stringOrNumber1 isKindOfClass:[NSString class]]) {
        one = [NSDecimalNumber decimalNumberWithString:stringOrNumber1];
    }else if([stringOrNumber1 isKindOfClass:[NSDecimalNumber class]]){
        one = stringOrNumber1;
    }else if ([stringOrNumber1 isKindOfClass:[NSNumber class]]){
        one = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber1 decimalValue]];
    }else{
        return -404;
    }
    
    if ([stringOrNumber2 isKindOfClass:[NSString class]]) {
        another = [NSDecimalNumber decimalNumberWithString:stringOrNumber2];
    }else if([stringOrNumber2 isKindOfClass:[NSDecimalNumber class]]){
        another = stringOrNumber2;
    }else if ([stringOrNumber2 isKindOfClass:[NSNumber class]]){
        another = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber2 decimalValue]];
    }else{
        return -404;
    }
    return [one compare:another];
}

+ (NSDecimalNumber *)add:(id)stringOrNumber1 another:(id)stringOrNumber2 {
    return [NSDecimalNumber decimalNumber:stringOrNumber1 type:SICalculationAdd anotherDecimalNumber:stringOrNumber2 andDecimalNumberHandler:nil];
}

+ (NSDecimalNumber *)sub:(id)stringOrNumber1 another:(id)stringOrNumber2 {
    return [NSDecimalNumber decimalNumber:stringOrNumber1 type:SICalculationSubtract anotherDecimalNumber:stringOrNumber2 andDecimalNumberHandler:nil];
}

+ (NSDecimalNumber *)div:(id)stringOrNumber1 another:(id)stringOrNumber2 {
    return [NSDecimalNumber decimalNumber:stringOrNumber1 type:SICalculationDivide anotherDecimalNumber:stringOrNumber2 andDecimalNumberHandler:nil];
}

+ (NSDecimalNumber *)mul:(id)stringOrNumber1 another:(id)stringOrNumber2 {
    return [NSDecimalNumber decimalNumber:stringOrNumber1 type:SICalculationMultiply anotherDecimalNumber:stringOrNumber2 andDecimalNumberHandler:nil];
}

+ (NSDecimalNumber *)min:(id)stringOrNumber1 another:(id)stringOrNumber2 {
    if (!stringOrNumber2 || !stringOrNumber1) return nil;
    NSDecimalNumber *one;
    NSDecimalNumber *another;
    if ([stringOrNumber1 isKindOfClass:[NSString class]]) {
        one = [NSDecimalNumber decimalNumberWithString:stringOrNumber1];
    }else if([stringOrNumber1 isKindOfClass:[NSDecimalNumber class]]){
        one = stringOrNumber1;
    }else if ([stringOrNumber1 isKindOfClass:[NSNumber class]]){
        one = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber1 decimalValue]];
    }else{
        return nil;
    }
    
    if ([stringOrNumber2 isKindOfClass:[NSString class]]) {
        another = [NSDecimalNumber decimalNumberWithString:stringOrNumber2];
    }else if([stringOrNumber2 isKindOfClass:[NSDecimalNumber class]]){
        another = stringOrNumber2;
    }else if ([stringOrNumber2 isKindOfClass:[NSNumber class]]){
        another = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber2 decimalValue]];
    }else{
        return nil;
    }
    
    if ([one compare:another] == NSOrderedAscending) {
        return one;
    }else {
        return another;
    }
}

+ (NSDecimalNumber *)max:(id)stringOrNumber1 another:(id)stringOrNumber2 {
    NSDecimalNumber *one;
    NSDecimalNumber *another;
    if ([stringOrNumber1 isKindOfClass:[NSString class]]) {
        one = [NSDecimalNumber decimalNumberWithString:stringOrNumber1];
    }else if([stringOrNumber1 isKindOfClass:[NSDecimalNumber class]]){
        one = stringOrNumber1;
    }else if ([stringOrNumber1 isKindOfClass:[NSNumber class]]){
        one = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber1 decimalValue]];
    }else{
        return nil;
    }
    
    if ([stringOrNumber2 isKindOfClass:[NSString class]]) {
        another = [NSDecimalNumber decimalNumberWithString:stringOrNumber2];
    }else if([stringOrNumber2 isKindOfClass:[NSDecimalNumber class]]){
        another = stringOrNumber2;
    }else if ([stringOrNumber2 isKindOfClass:[NSNumber class]]){
        another = [NSDecimalNumber decimalNumberWithDecimal:[stringOrNumber2 decimalValue]];
    }else{
        return nil;
    }
    
    if ([one compare:another] == NSOrderedAscending) {
        return another;
    }else {
        return one;
    }
}

@end
