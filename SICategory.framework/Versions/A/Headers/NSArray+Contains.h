//
//  NSArray+Contains.h
//  Category
//
//  Created by Silence on 19/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Contains)


/**
 是否包含所有数组中元素

 @param array 要寻找的Array
 @return 是否包含
 */
-(BOOL)containsAll:(NSArray *)array;


/**
 是否包含其中任意一个元素

 @param array 要寻找的Array
 @return 是否包含
 */
-(BOOL)containsAny:(NSArray *)array;

@end
