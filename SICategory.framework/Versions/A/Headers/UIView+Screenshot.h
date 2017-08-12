//
//  UIView+Screenshot.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)

///  截取当前View
- (nullable UIImage *)snapshotImage;

- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
/// 截取当前View为PDF
- (nullable NSData *)snapshotPDF;

@end
