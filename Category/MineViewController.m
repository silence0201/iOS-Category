
//
//  MineViewController.m
//  Category
//
//  Created by Silence on 2017/5/29.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "MineViewController.h"
#import "UIViewController+BackAction.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backButtonTouched:^(UINavigationController *nav) {
        NSLog(@"点击了返回按钮") ;
        [nav popViewControllerAnimated:YES] ;
    }] ;
}
@end
