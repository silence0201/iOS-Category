//
//  UIScrollView+Amplification.h
//  Category
//
//  Created by 杨晴贺 on 04/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Amplification)

@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UIView *headerView;
-(void)setBigView:(UIView *)bigView withHeaderView:(UIView *)headerView;

@end
