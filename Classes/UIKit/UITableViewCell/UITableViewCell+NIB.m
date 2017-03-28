//
//  UITableViewCell+NIB.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UITableViewCell+NIB.h"

@implementation UITableViewCell (NIB)

+ (UINib *)nib {
    return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
