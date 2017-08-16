//
//  NSURL+QueryDictionary.h
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (UQ_URLQuery)

/**
 查询参数的字典

 @return 参数字典
 */
- (NSDictionary*)queryDictionary;

/**
 添加查询参数字典

 @param queryDictionary 查询字典信息
 @param sortedKeys 是否排序
 @return 返回的NSURL
 */
- (NSURL*)URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary
                            withSortedKeys:(BOOL) sortedKeys;

/**
 添加查询参数字典

 @param queryDictionary 查询字典信息
 @return 返回的NSURL
 */
- (NSURL*)URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary;


/**
 替换查询参数信息

 @param queryDictionary 查询字典信息
 @param sortedKeys 是否排序
 @return 返回的NSURL
 */
- (NSURL*)URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary
                                withSortedKeys:(BOOL) sortedKeys;

/**
 替换查询参数信息

 @param queryDictionary 查询字典信息
 @return 返回的NSURL
 */
- (NSURL*)URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary;

/**
 移除查询参数信息

 @return 移除后的NSURL
 */
- (NSURL*)URLByRemovingQuery;

@end

