//
//  NSDictionary+JSONEncode.h
//  Category
//
//  Created by Silence on 31/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONEncode)

/**
 JSON String Encoded

 @return JSON String
 */
- (nullable NSString *)jsonStringEncoded;


/**
 JSON PrettyString Encoded

 @return JSON Pretty String
 */
- (nullable NSString *)jsonPrettyStringEncoded;

@end
