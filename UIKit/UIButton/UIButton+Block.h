//
//  UIButton+Block.h
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchedBlock)(id sender);
@interface UIButton (Block)

/// 给点击状态添加事件
-(void)addActionHandler:(TouchedBlock)touchHandler;

@end
