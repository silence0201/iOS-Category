//
//  SIKeychainManager.m
//  Category
//
//  Created by 杨晴贺 on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "SIKeychainManager.h"

#import <UIKit/UIKit.h>

static BOOL kDebugMode  = NO;
static NSString *kUDIDValue = nil;
static NSString *const kKeychainUDIDItemIdentifier  = @"UDID";   // 这里可以替换为你的UDID
static NSString *const kKeychainUDIDItemServiceName = @"com.silence.UDID"; // 替换你的服务名,通常用应用的BundleID


@implementation SIKeychainManager

+ (NSString *)value {
    if (kUDIDValue == nil) {
        @synchronized ([self class]) {
            NSData *itemData = [self selectKeychainItemWithIdentifier:kKeychainUDIDItemIdentifier serviceName:kKeychainUDIDItemServiceName];
            if (itemData) {
                kUDIDValue = [[NSString alloc]initWithData:itemData encoding:NSUTF8StringEncoding];
            } else {
                kUDIDValue = [self getIDFVString];
                [self insertKeychainItemWithValue:kUDIDValue identifier:kKeychainUDIDItemIdentifier serviceName:kKeychainUDIDItemServiceName];
            }
        }
    }
    
    return kUDIDValue;
}

+ (void)setDebug:(BOOL)mode {
    kDebugMode = mode;
}


#pragma mark - Extension Method: Insert / Delete / Update / Select
+ (NSData *)selectKeychainItemWithIdentifier:(NSString *)identifier serviceName:(NSString *)serviceName {
    NSMutableDictionary *dicForSelect = [self baseAttributeDictionary:identifier serviceName:serviceName];
    [dicForSelect setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [dicForSelect setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    NSData *result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)dicForSelect, (void *)&result);
    if (status == errSecSuccess) {
        NSLog(@"查找成功") ;
    } else {
        NSLog(@"查找失败") ;
    }
    [self logAction:@"SecItemCopyMatching" status:(NSInteger)status];
    
    return result;
}

+ (BOOL)insertKeychainItemWithValue:(NSString *)value identifier:(NSString *)identifier serviceName:(NSString *)serviceName {
    NSMutableDictionary *dicForInsert = [self baseAttributeDictionary:identifier serviceName:serviceName];
    NSData *dataForInsert = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dicForInsert setObject:dataForInsert forKey:(id)kSecValueData];
    
    BOOL isSucceeded;
    OSStatus status = SecItemAdd((CFDictionaryRef)dicForInsert, NULL);
    if (status == errSecSuccess) {
        isSucceeded = YES;
    } else {
        isSucceeded = NO;
    }
    [self logAction:@"SecItemAdd" status:(NSInteger)status];
    
    return isSucceeded;
}

+ (BOOL)updateKeychainItemWithValue:(NSString *)value identifier:(NSString *)identifier serviceName:(NSString *)serviceName {
    NSMutableDictionary *dicForSelect = [self baseAttributeDictionary:identifier serviceName:serviceName];
    
    NSMutableDictionary *dicForUpdate = [[NSMutableDictionary alloc]init];
    NSData *dataForUpdate = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dicForUpdate setObject:dataForUpdate forKey:(id)kSecValueData];
    
    BOOL isSucceeded;
    OSStatus status = SecItemUpdate((CFDictionaryRef)dicForSelect, (CFDictionaryRef)dicForUpdate);
    if (status == errSecSuccess) {
        isSucceeded = YES;
    } else {
        isSucceeded = NO;
    }
    [self logAction:@"SecItemUpdate" status:(NSInteger)status];
    
    return isSucceeded;
}

+ (BOOL)deleteKeychainItemWithIdentifier:(NSString *)identifier serviceName:(NSString *)serviceName {
    NSMutableDictionary *dicForDelete = [self baseAttributeDictionary:identifier serviceName:serviceName];
    
    BOOL isSucceeded;
    OSStatus status = SecItemDelete((CFDictionaryRef)dicForDelete);
    if (status == errSecSuccess) {
        isSucceeded = YES;
    } else {
        isSucceeded = NO;
    }
    [self logAction:@"SecItemDelete" status:(NSInteger)status];
    
    return isSucceeded;
}

#pragma mark - Private Method
+ (NSString *)getIDFVString {
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSMutableDictionary *)baseAttributeDictionary:(NSString *)identifier serviceName:(NSString *)serviceName {
    NSMutableDictionary *baseAttributeDictionary = [[NSMutableDictionary alloc] init];
    [baseAttributeDictionary setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [baseAttributeDictionary setObject:encodedIdentifier forKey:(id)kSecAttrGeneric];
    [baseAttributeDictionary setObject:encodedIdentifier forKey:(id)kSecAttrAccount];
    [baseAttributeDictionary setObject:serviceName forKey:(id)kSecAttrService];
    return baseAttributeDictionary;
}

+ (void)logAction:(NSString *)action status:(NSInteger)status {
    if (kDebugMode) {
        NSLog(@"%@ Executed: `[KeychainAction: %@], [OSStatus: %ld]`", NSStringFromClass(self.class), action ,(long)status);
    }
}

@end

