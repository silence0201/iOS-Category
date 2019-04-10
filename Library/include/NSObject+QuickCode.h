//
//  NSObject+QuickCode.h
//  Category
//
//  Created by Silence on 30/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (QuickCode)

/** 快速归档 */
- (id)quickCoderWith:(NSCoder *)aDecoder ;

/** 快速解档 */
- (void)quickEncodeWithCoder:(NSCoder *)aCoder ;

@end
