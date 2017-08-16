//
//  NSIndexPath+Offset.h
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSIndexPath (Offset)

/// previous row indexpath
- (NSIndexPath *)previousRow;

/// next row indexpath
- (NSIndexPath *)nextRow;

/// previous item indexpath
- (NSIndexPath *)previousItem;

/// next item indexpath
- (NSIndexPath *)nextItem;

/// next section indexpath
- (NSIndexPath *)nextSection;

/// previous section indexpath
- (NSIndexPath *)previousSection;

@end
