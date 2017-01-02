//
//  UIView+Screenshot.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)

- (nullable UIImage *)snapshotImage;
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
- (nullable NSData *)snapshotPDF;

@end
