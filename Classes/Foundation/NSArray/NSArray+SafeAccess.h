//
//  NSArray+SafeAccess.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeAccess)

/**随机获取一个对象 */
- (id)randomObject;

/** 安全访问一个对象 */
- (id)objectWithIndex:(NSUInteger)index ;

- (NSNumber*)numberWithIndex:(NSUInteger)index;
- (NSArray*)arrayWithIndex:(NSUInteger)index;
- (NSDictionary*)dictionaryWithIndex:(NSUInteger)index;
- (NSInteger)integerWithIndex:(NSUInteger)index;
- (NSUInteger)unsignedIntegerWithIndex:(NSUInteger)index;
- (BOOL)boolWithIndex:(NSUInteger)index;
- (int16_t)int16WithIndex:(NSUInteger)index;
- (int32_t)int32WithIndex:(NSUInteger)index;
- (int64_t)int64WithIndex:(NSUInteger)index;
- (char)charWithIndex:(NSUInteger)index;
- (short)shortWithIndex:(NSUInteger)index;
- (float)floatWithIndex:(NSUInteger)index;
- (double)doubleWithIndex:(NSUInteger)index;

@end

@interface NSMutableArray (SafeAccess)

- (void)removeFirstObject;

- (id)popFirstObject;
- (id)popLastObject;


- (void)prependObject:(id)anObject;
- (void)prependObjects:(NSArray *)objects;

- (void)appendObject:(id)anObject;
- (void)appendObjects:(NSArray *)objects;

- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

-(void)appendString:(NSString*)i;
-(void)appendBool:(BOOL)i;
-(void)appendInt:(int)i;
-(void)appendInteger:(NSInteger)i;
-(void)appendUnsignedInteger:(NSUInteger)i;
-(void)appendChar:(char)c;
-(void)appendFloat:(float)i;

- (void)reverse;
- (void)shuffle;

@end
