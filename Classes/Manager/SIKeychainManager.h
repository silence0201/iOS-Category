//
//  SIKeychainManager.h
//  Category
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIKeychainManager : NSObject

#pragma mark -- UDID

/**
 *  method             value, Requires iOS6.0 and later return UDID(Unique Device Identity)
 */
+ (NSString *)value;


/**
 *  method             setDebug:
 *  abstract           Set `YES` to open debug mode, defalut is `NO`.
 */
+ (void)setDebug:(BOOL)mode;

#pragma mark -- Extension Method: Insert / Delete / Update / Select
/**
 *  method             selectKeychainItemWithIdentifier: serviceName:
 *  abstract           Find out if the item already exists in the keychain. If exist, return the item, else return nil.
 */
+ (NSData *)selectKeychainItemWithIdentifier:(NSString *)identifier serviceName:(NSString *)serviceName;

/**
 *  method             insertKeychainItemWithValue: identifier: serviceName:
 *  abstract           Insert an item into keychain. If success, return YES, else return NO.
 */
+ (BOOL)insertKeychainItemWithValue:(NSString *)value identifier:(NSString *)identifier serviceName:(NSString *)serviceName;

/**
 *  method             updateKeychainItemWithValue: identifier: serviceName:
 *  abstract           Update a keychain item, If success, return YES, else return NO.
 */
+ (BOOL)updateKeychainItemWithValue:(NSString *)value identifier:(NSString *)identifier serviceName:(NSString *)serviceName;

/**
 *  method             deleteKeychainItemWithIdentifier: serviceName:
 *  abstract           Delete a keychain item. If success, return YES, else return NO.
 */
+ (BOOL)deleteKeychainItemWithIdentifier:(NSString *)identifier serviceName:(NSString *)serviceName;


@end
