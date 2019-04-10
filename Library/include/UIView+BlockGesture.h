//
//  UIView+BlockGesture.h
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (BlockGesture)

/// 添加点击手势
- (void)addTapActionWithBlock:(GestureActionBlock)block;
/// 添加长按手势
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

@end
