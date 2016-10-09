//
//  NSString+RegularJudement.h
//  Category
//
//  Created by 杨晴贺 on 09/10/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegularJudement)

#pragma 正则匹配手机号
- (BOOL)checkTelNumber ;

#pragma 正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPassword ;

#pragma 正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName ;

#pragma 正则匹配用户身份证号15或18位
- (BOOL)checkUserIdCard ;

#pragma 正则匹配邮箱
- (BOOL)checkUserEmail ;

#pragma 正则匹配银行卡号
- (BOOL)checkUserBankNumber ;

#pragma 正则匹配用验证身份证户身份证号15或18位
- (BOOL)validateIdentityCard ;


@end
