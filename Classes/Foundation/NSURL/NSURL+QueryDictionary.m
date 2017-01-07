//
//  NSURL+QueryDictionary.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//
#import "NSURL+QueryDictionary.h"

static NSString *const kURLReservedChars    = @"￼=,!$&'()*+;@?\r\n\"<>#\t :/";
static NSString *const kQuerySeparator      = @"&";
static NSString *const kQueryDivider        = @"=";
static NSString *const kQueryBegin          = @"?";
static NSString *const kFragmentBegin       = @"#";


@interface NSString (_URLQuery)

- (NSDictionary*)_URLQueryDictionary;

@end

@interface NSDictionary (_URLQuery)

- (NSString*)_URLQueryStringWithSortedKeys:(BOOL) sortedKeys;
- (NSString*)_URLQueryString;

@end

@implementation NSString (_URLQuery)

- (NSDictionary*)_URLQueryDictionary {
    NSMutableDictionary *mute = @{}.mutableCopy;
    for (NSString *query in [self componentsSeparatedByString:kQuerySeparator]) {
        NSArray *components = [query componentsSeparatedByString:kQueryDivider];
        if (components.count == 0) {
            continue;
        }
        NSString *key = [components[0] stringByRemovingPercentEncoding];
        id value = nil;
        if (components.count == 1) {
            value = [NSNull null];
        }
        if (components.count == 2) {
            value = [components[1] stringByRemovingPercentEncoding];
            value = [value length] ? value : [NSNull null];
        }
        if (components.count > 2) {
            continue;
        }
        mute[key] = value ?: [NSNull null];
    }
    return mute.count ? mute.copy : nil;
}

- (NSString*)_stringByPercentageEncodingWithReservedCharacters {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end

@implementation NSDictionary (_URLQuery)

- (NSString *)_URLQueryString {
    return [self _URLQueryStringWithSortedKeys:NO];
}

- (NSString*)_URLQueryStringWithSortedKeys:(BOOL)sortedKeys {
    NSMutableString *queryString = @"".mutableCopy;
    NSArray *keys = sortedKeys ? [self.allKeys sortedArrayUsingSelector:@selector(compare:)] : self.allKeys;
    for (NSString *key in keys) {
        id rawValue = self[key];
        NSString *value = nil;
        if (!(rawValue == [NSNull null] || ![rawValue description].length)) {
            value = [self[key] description];
        }
        [queryString appendFormat:@"%@%@%@%@",
         queryString.length ? kQuerySeparator : @"",    // appending?
         key,
         value ? kQueryDivider : @"",
         value ? value : @""];
    }
    return queryString.length ? [queryString _stringByPercentageEncodingWithReservedCharacters] : nil;
}

@end

@implementation NSURL (UQ_URLQuery)

- (NSDictionary*)queryDictionary {
  return self.query._URLQueryDictionary;
}

- (NSURL*)URLByAppendingQueryDictionary:(NSDictionary*)queryDictionary {
  return [self URLByAppendingQueryDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL *)URLByAppendingQueryDictionary:(NSDictionary *)queryDictionary
                             withSortedKeys:(BOOL)sortedKeys{
  NSMutableArray *queries = [self.query length] > 0 ? @[self.query].mutableCopy : @[].mutableCopy;
  NSString *dictionaryQuery = [queryDictionary _URLQueryStringWithSortedKeys:sortedKeys];
  if (dictionaryQuery) {
    [queries addObject:dictionaryQuery];
  }
  NSString *newQuery = [queries componentsJoinedByString:kQuerySeparator];
  if (newQuery.length) {
    NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:kQueryBegin];
    if (queryComponents.count) {
      return [NSURL URLWithString:
              [NSString stringWithFormat:@"%@%@%@%@%@",
               queryComponents[0],
               kQueryBegin,
               newQuery,
               self.fragment.length ? kFragmentBegin : @"",
               self.fragment.length ? self.fragment : @""]];
    }
  }
  return self;
}

- (NSURL*)URLByRemovingQuery {
  NSArray *queryComponents = [self.absoluteString componentsSeparatedByString:kQueryBegin];
  if (queryComponents.count) {
    return [NSURL URLWithString:queryComponents.firstObject];
  }
  return self;
}

- (NSURL *)URLByReplacingQueryWithDictionary:(NSDictionary *)queryDictionary {
  return [self URLByReplacingQueryWithDictionary:queryDictionary withSortedKeys:NO];
}

- (NSURL*)URLByReplacingQueryWithDictionary:(NSDictionary*)queryDictionary
                                withSortedKeys:(BOOL) sortedKeys{
  NSURL *stripped = [self URLByRemovingQuery];
  return [stripped URLByAppendingQueryDictionary:queryDictionary withSortedKeys:sortedKeys];
}

@end


