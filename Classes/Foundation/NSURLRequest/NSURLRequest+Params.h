//
//  NSURLRequest+Params.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (Params)

- (id)initWithURL:(NSURL *)URL parameters:(NSDictionary *)params;

+(NSURLRequest *)requestGETWithURL:(NSURL *)url parameters:(NSDictionary *)params;

+(NSString *)URLfromParameters:(NSDictionary *)params;

+(NSArray *)queryStringComponentsFromKey:(NSString *)key value:(id)value;
+(NSArray *)queryStringComponentsFromKey:(NSString *)key dictionaryValue:(NSDictionary *)dict;
+(NSArray *)queryStringComponentsFromKey:(NSString *)key arrayValue:(NSArray *)array;

@end
