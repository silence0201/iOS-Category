//
//  NSString+VersionCompare.h
//  Category
//
//  Created by Silence on 2018/1/18.
//  Copyright © 2018年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VersionCompare)

-(NSComparisonResult)compareToVersion:(NSString *)version;

-(BOOL)isOlderThanVersion:(NSString *)version;
-(BOOL)isNewerThanVersion:(NSString *)version;
-(BOOL)isEqualToVersion:(NSString *)version;
-(BOOL)isEqualOrOlderThanVersion:(NSString *)version;
-(BOOL)isEqualOrNewerThanVersion:(NSString *)version;

- (NSString *)getMainVersionWithIntegerCount:(NSInteger)integerCount;
- (BOOL)needsToUpdateToVersion:(NSString *)newVersion mainVersionIntegerCount:(NSInteger)integerCount;

@end
