//
//  UIViewController+RecursiveDescription.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RecursiveDescription)

/**
 *  @brief  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)recursiveDescription;

@end
