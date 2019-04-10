//
//  UIBezierPath+Length.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Length)

- (CGFloat)length;

- (CGPoint)pointAtPercentOfLength:(CGFloat)percent;

@end
