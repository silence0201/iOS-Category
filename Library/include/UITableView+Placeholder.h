//
//  UITableView+Placeholder.h
//  Category
//
//  Created by Silence on 2017/12/20.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlaceholderClickBlock)(UIView *view);

@interface UITableView (Placeholder)

@property (nonatomic, assign) BOOL showPlaceholder;

@property (nonatomic, copy) PlaceholderClickBlock placeholderClickBlock;
@property (nonatomic, copy) NSString *placeholderText;
@property (nonatomic, copy) UIImage *placeholderImage;
@property (nonatomic, copy) UIView *placeholderCustomView;

@end
