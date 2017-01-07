//
//  NSString+JSONValue.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSONValue)

- (NSDictionary *) JSONDictionaryValue ;

- (NSArray *)JSONArrayValue ;

@end
