//
//  UIView+AnchorPoint.m
//  Category
//
//  Created by 杨晴贺 on 9/6/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIView+AnchorPoint.h"

@implementation UIView (AnchorPoint)

- (void)si_setAnchorPoint:(CGPoint)point{
    CGPoint oldOrigin = self.frame.origin ;
    self.layer.anchorPoint = point ;
    CGPoint newOrigin = self.frame.origin ;
    
    CGPoint transition ;
    transition.x = newOrigin.x - oldOrigin.x ;
    transition.y = newOrigin.y - oldOrigin.y ;
    
    self.center = CGPointMake (self.center.x - transition.x, self.center.y - transition.y);
}

- (void)si_setAnchroPoint2:(CGPoint)point{
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = point;
    self.frame = oldFrame;
}

@end
