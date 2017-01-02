//
//  UIControl+Block.h
//  Category
//  https://github.com/hypercrypt/uicontrol-blocks
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIControl *sender, UIEvent *event);
@interface UIControl (Block)

- (id)addActionForControlEvents:(UIControlEvents)controlEvents
                     usingBlock:(ActionBlock)block;
- (void)removeAllActions;
- (void)removeAction:(id)action;

@end
