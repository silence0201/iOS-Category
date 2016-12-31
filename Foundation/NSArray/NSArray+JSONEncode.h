//
//  NSArray+JSONEncode.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSONEncode)

- (NSString *)jsonStringEncoded;
- (NSString *)jsonPrettyStringEncoded;

@end
