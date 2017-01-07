//
//  NSDictionary+JSONEncode.h
//  Category
//
//  Created by 杨晴贺 on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONEncode)

- (nullable NSString *)jsonStringEncoded;
- (nullable NSString *)jsonPrettyStringEncoded;

@end
