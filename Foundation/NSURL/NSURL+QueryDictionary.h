//
//  NSURL+QueryDictionary.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (UQ_URLQuery)

- (NSDictionary*)queryDictionary;

- (NSURL*)URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary
                            withSortedKeys:(BOOL) sortedKeys;
- (NSURL*)URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary;


- (NSURL*)URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary
                                withSortedKeys:(BOOL) sortedKeys;
- (NSURL*)URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary;

- (NSURL*)URLByRemovingQuery;

@end

