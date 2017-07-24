//
//  SIKeychainManager.h
//  Category
//
//  Created by 杨晴贺 on 2017/7/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIKeychainManager : NSObject

+ (BOOL)saveValue:(id)value forKey:(NSString*)key forAccessGroup:(NSString *)group;
+ (BOOL)saveValue:(id)value forKey:(NSString*)key;

+ (BOOL)deleteValueForKey:(NSString *)key forAccessGroup:(NSString *)group;
+ (BOOL)deleteValueForKey:(NSString *)key;

+ (id)loadValueForKey:(NSString*)key forAccessGroup:(NSString *)group;
+ (id)loadValueForKey:(NSString*)key;

+ (NSString *)getBundleSeedIdentifier;

@end
