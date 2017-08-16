//
//  UIImage+Video.m
//  Category
//
//  Created by Silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIImage+Video.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Video)

+ (UIImage *)imageWithVideo:(NSString *)stringURL{
    NSURL *url =[NSURL URLWithString:stringURL];
    // 根据视频的URL创建AVURLAsset
    AVURLAsset *asset =[[AVURLAsset alloc]initWithURL:url options:nil];
    // 根据AVURLAsset创建AVAssetImageGenerator对象
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    // 定义a为获取0帧处的视频截图,第二个参数b是每秒多少帧，a/b当前播放时间
    CMTime time =CMTimeMake(0, 10);
    NSError *error = nil;
    CMTime actualTime;
    // 获取time处的视频截图
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    // 将CGImageRef转化成UIImage
    UIImage *temb = [[UIImage alloc]initWithCGImage:image];
    CGImageRelease(image);
    return temb;
}

@end
