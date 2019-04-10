//
//  CAShapeLayer+UIBezierPath.h
//  Category
//
//  Created by Silence on 2017/4/24.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (UIBezierPath)

/**Update CAShapeLayer with UIBezierPath.*/
- (void)updateWithBezierPath:(UIBezierPath *)path;

/**Get UIBezierPath object, constructed from CAShapeLayer.*/
- (UIBezierPath *)bezierPath;

@end
