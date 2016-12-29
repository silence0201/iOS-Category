//
//  NSString+Check.m
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)


- (BOOL)checkNumber {
    NSString *nicknameRegex = @"^[0-9]*$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//正则判断手机号码格式

- (BOOL)checkPhone {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:self] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL)checkRealName {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,4}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//昵称
- (BOOL)checkNickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5\\w]{4,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
    
}

//身份证号
- (BOOL)checkIdentityCard {
    if (self.length <= 0)
        return NO;
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

//邮箱
- (BOOL)checkEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
}

//邮编
- (BOOL)checkPostcode{
    NSString *postcode = @"^[1-9]\\d{5}$";
    NSPredicate *postcodePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",postcode];
    return [postcodePredicate evaluateWithObject:self];
}

//验证密码是否是6-20位必须包含数字以及字母
- (BOOL)checkPassword {
    NSString *passwordRegex1 = @"^([a-zA-Z]+[0-9]+[a-zA-Z0-9]+)|([a-zA-Z]+[0-9]+)$";
    NSString *passwordRegex2 = @"^([0-9]+[a-zA-Z]+[a-zA-Z0-9]+)|([0-9]+[a-zA-Z]+)$";
    NSPredicate *passWordPredicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex1];
    NSPredicate *passWordPredicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex2];
    if ([passWordPredicate1 evaluateWithObject:self] && self.length >= 6 && self.length <= 20) {
        return YES;
    }else if([passWordPredicate2 evaluateWithObject:self] && self.length >= 6 && self.length <= 20) {
        return YES;
    }
    return NO;
}

/** 删除所有的空格 */
-(NSString *)deleteSpace{
    NSMutableString *strM = [NSMutableString stringWithString:self];
    [strM replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, strM.length)];
    return [strM copy];
}

@end
