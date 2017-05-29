//
//  UIViewController+BackAction.h
//  Category
//
//  Created by 杨晴贺 on 2017/5/29.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SIBackAction)(UINavigationController *vc);

@interface UIViewController (BackAction)

-(void)backButtonTouched:(SIBackAction)backButtonHandler;

@end
