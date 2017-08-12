//
//  NSString+Segmentation.h
//  Category
//  https://github.com/cyanzhong/segmentation
//  Created by 杨晴贺 on 2017/7/15.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, SegmentationOptions) {
    SegmentationOptionsNone              = 0,
    SegmentationOptionsDeduplication     = 1 << 0,   // 是否删除重复数据
    SegmentationOptionsKeepEnglish       = 1 << 1,   // 是否包含英文
    SegmentationOptionsKeepSymbols       = 1 << 2,   // 是否包含符号
};

@interface NSString (Segmentation)

- (NSArray <NSString *> *)segment:(SegmentationOptions)options;

@end
