//
//  NSString+PinYin.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PinYin)

/**
 带音调的PinYin

 @return PinYin String
 */
- (NSString*)pinyinWithPhoneticSymbol;


/**
 拼音

 @return PinYin String
 */
- (NSString*)pinyin;


/**
 拼音Array

 @return PinYin Array
 */
- (NSArray*)pinyinArray;


/**
 删除空格的PinYin

 @return PinYin String
 */
- (NSString*)pinyinWithoutBlank;

/**
 拼音开头字母Array

 @return 开头字母Array
 */
- (NSArray*)pinyinInitialsArray;

/**
 拼音开头字母String

 @return 开头字母String
 */
- (NSString*)pinyinInitialsString;

@end
