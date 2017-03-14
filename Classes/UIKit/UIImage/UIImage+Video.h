//
//  UIImage+Video.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Video)

/// 获取视频的截图信息
+ (UIImage *)imageWithVideo:(NSString *)stringURL;

@end
