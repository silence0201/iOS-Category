//
//  UIView+ViewPath.h
//  ViewPathDemo
//
//  Created by Silence on 2019/4/8.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ViewPath)

@property (nonatomic, readonly) NSString *viewPath;

@property (nonatomic ,readonly) NSString *viewID;

@end

NS_ASSUME_NONNULL_END
