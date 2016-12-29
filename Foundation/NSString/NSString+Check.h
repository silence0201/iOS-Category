//
//  NSString+Check.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)

//是否是纯数字
@property (nonatomic, assign, readonly) BOOL checkNumber;
//手机号
@property (nonatomic, assign, readonly) BOOL checkPhone;
//真实姓名
@property (nonatomic, assign, readonly) BOOL checkRealName;
//昵称
@property (nonatomic, assign, readonly) BOOL checkNickname;
//身份证号
@property (nonatomic, assign, readonly) BOOL checkIdentityCard;
//邮箱
@property (nonatomic, assign, readonly) BOOL checkEmail;
//验证密码
@property (nonatomic, assign, readonly) BOOL checkPassword;
/** 删除所有的空格 */
@property (nonatomic,copy,readonly) NSString *deleteSpace;
//邮编
@property (nonatomic, assign, readonly) BOOL checkPostcode;

@end
