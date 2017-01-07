//
//  NSString+PinYin.h
//  Category
//
//  Created by 杨晴贺 on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PinYin)

- (NSString*)pinyinWithPhoneticSymbol;

- (NSString*)pinyin;

- (NSArray*)pinyinArray;

- (NSString*)pinyinWithoutBlank;

- (NSArray*)pinyinInitialsArray;

- (NSString*)pinyinInitialsString;

@end
