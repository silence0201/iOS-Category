//
//  NSDictionary+SafeAccess.h
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeAccess)

- (NSString*)stringForKey:(id)key;
- (NSNumber*)numberForKey:(id)key;
- (NSArray*)arrayForKey:(id)key;
- (NSDictionary*)dictionaryForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key;
- (BOOL)boolForKey:(id)key;
- (int16_t)int16ForKey:(id)key;
- (int32_t)int32ForKey:(id)key;
- (int64_t)int64ForKey:(id)key;
- (char)charForKey:(id)key;
- (short)shortForKey:(id)key;
- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key;
- (long long)longLongForKey:(id)key;
- (unsigned long long)unsignedLongLongForKey:(id)key;

@end

@interface NSMutableDictionary (SafeAccess)

-(void)setObj:(id)i forKey:(NSString*)key;
-(void)setString:(NSString*)i forKey:(NSString*)key;
-(void)setBool:(BOOL)i forKey:(NSString*)key;
-(void)setInt:(int)i forKey:(NSString*)key;
-(void)setInteger:(NSInteger)i forKey:(NSString*)key;
-(void)setUnsignedInteger:(NSUInteger)i forKey:(NSString*)key;
-(void)setChar:(char)c forKey:(NSString*)key;
-(void)setFloat:(float)i forKey:(NSString*)key;
-(void)setDouble:(double)i forKey:(NSString*)key;
-(void)setLongLong:(long long)i forKey:(NSString*)key;

@end
