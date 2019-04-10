//
//  NSUserDefaults+iCloudSync.h
//  Category
//
//  Created by Silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (iCloudSync)

-(void)setValue:(id)value  forKey:(NSString *)key iCloudSync:(BOOL)sync;
-(void)setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

-(id)valueForKey:(NSString *)key  iCloudSync:(BOOL)sync;
-(id)objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

-(BOOL)synchronizeAlsoiCloudSync:(BOOL)sync;

@end
