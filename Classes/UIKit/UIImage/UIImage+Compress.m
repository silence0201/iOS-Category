//
//  UIImage+Compress.m
//  Category
//
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIImage+Compress.h"

@implementation UIImage (Compress)
#pragma mark --------前台压缩（可能比较慢，造成当前进程卡住）
+ (NSData *)CompressToDataWithImage:(UIImage *)OldImage
                          ShowSize:(CGSize)ShowSize
                          FileSize:(NSInteger)FileSize{
    UIImage *oldIMG = OldImage;
    UIImage *thumIMG = [self ResizeImageWithImage:oldIMG
                                          andSize:ShowSize
                                            Scale:NO];
    NSData  *outIMGData = [self OnlyCompressToDataWithImage:thumIMG
                                                   FileSize:(FileSize*1024)];
    CGSize scalesize = ShowSize;
    //如果压缩后还是无法达到文件大小，则降低分辨率，继续压缩
    while (outIMGData.length>(FileSize*1024)) {
        scalesize = CGSizeMake(scalesize.width*0.8, scalesize.height*0.8);
        thumIMG = [self ResizeImageWithImage:oldIMG
                                     andSize:scalesize
                                       Scale:NO];
        outIMGData = [self OnlyCompressToDataWithImage:thumIMG
                                              FileSize:(FileSize*1024)];
    }
    return outIMGData;
}

+ (UIImage *)CompressToImageWithImage:(UIImage *)OldImage
                            ShowSize:(CGSize)ShowSize
                            FileSize:(NSInteger)FileSize{
    UIImage *oldIMG = OldImage;
    UIImage *thumIMG = [self ResizeImageWithImage:oldIMG
                                          andSize:ShowSize
                                            Scale:NO];
    UIImage *outIMG = [self OnlyCompressToImageWithImage:thumIMG
                                                FileSize:(FileSize*1024)];
    NSData * newimageData = UIImageJPEGRepresentation(outIMG,1);
    CGSize scalesize = ShowSize;
    //如果压缩后还是无法达到文件大小，则降低分辨率，继续压缩
    while ([newimageData length]>(FileSize*1024)) {
        scalesize = CGSizeMake(scalesize.width*0.8, scalesize.height*0.8);
        thumIMG = [self ResizeImageWithImage:outIMG
                                     andSize:scalesize
                                       Scale:NO];
        outIMG = [self OnlyCompressToImageWithImage:thumIMG
                                           FileSize:(FileSize*1024)];
        newimageData = UIImageJPEGRepresentation(outIMG,1);
    }
    NSLog(@"压缩完成");
    return outIMG;
}


#pragma mark --------后台压缩（异步进行，不会卡住前台进程）
+ (void)CompressToDataAtBackgroundWithImage:(UIImage *)OldImage
                                  ShowSize:(CGSize)ShowSize
                                  FileSize:(NSInteger)FileSize
                                     block:(DataBlock)DataBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *newIMGData = [self CompressToDataWithImage:OldImage
                                                                 ShowSize:ShowSize
                                                                 FileSize:FileSize];
        DataBlock(newIMGData);
    });
}


+ (void)CompressToImageAtBackgroundWithImage:(UIImage *)OldImage
                                   ShowSize:(CGSize)ShowSize
                                   FileSize:(NSInteger)FileSize
                                      block:(ImgBlock)ImgBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *newIMG = [self CompressToImageWithImage:OldImage
                                                               ShowSize:ShowSize
                                                               FileSize:FileSize];
        ImgBlock(newIMG);
    });
}


#pragma mark --------细化调用方法
+ (UIImage *)OnlyCompressToImageWithImage:(UIImage *)OldImage
                                 FileSize:(NSInteger)FileSize{
    CGFloat compression    = 0.9f;
    CGFloat minCompression = 0.01f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    //每次减少的比例
    float scale = 0.1;
    //新UIImage的Data
    NSData * newimageData = UIImageJPEGRepresentation(OldImage,1);
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression)&&
           (newimageData.length>FileSize)){
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
        UIImage *compressedImage = [UIImage imageWithData:imageData];
        newimageData= UIImageJPEGRepresentation(compressedImage,1);
        compression -= scale;
    }
    UIImage *compressedImage = [UIImage imageWithData:newimageData];
    return compressedImage;
}

+ (NSData *)OnlyCompressToDataWithImage:(UIImage *)OldImage
                               FileSize:(NSInteger)FileSize{
    CGFloat compression    = 1.0f;
    CGFloat minCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(OldImage,
                                                  compression);
    //每次减少的比例
    float scale = 0.1;
    //循环条件：没到最小压缩比例，且没压缩到目标大小
    while ((compression > minCompression)&&
           (imageData.length>FileSize)){
        compression -= scale;
        imageData = UIImageJPEGRepresentation(OldImage,
                                              compression);
        
    }
    return imageData;
}



//------只缩不压
//若Scale为YES，则原图会根据Size进行拉伸-会变形
//若Scale为NO，则原图会根据Size进行填充-不会变形
+(UIImage *)ResizeImageWithImage:(UIImage *)OldImage
                         andSize:(CGSize)Size
                           Scale:(BOOL)Scale
{
    UIGraphicsBeginImageContextWithOptions(Size, NO, 0.0);
    
    CGRect rect = CGRectMake(0,
                             0,
                             Size.width,
                             Size.height);
    if (!Scale) {
        
        CGFloat bili_imageWH = OldImage.size.width/
        OldImage.size.height;
        CGFloat bili_SizeWH  = Size.width/Size.height;
        
        if (bili_imageWH > bili_SizeWH) {
            
            CGFloat bili_SizeH_imageH = Size.height/
            OldImage.size.height;
            CGFloat height = OldImage.size.height*
            bili_SizeH_imageH;
            CGFloat width = height * bili_imageWH;
            CGFloat x = -(width - Size.width)/2;
            CGFloat y = 0;
            rect = CGRectMake(x,y,
                              width,
                              height);
            
        }else{
            
            CGFloat bili_SizeW_imageW = Size.width/
            OldImage.size.width;
            CGFloat width = OldImage.size.width *
            bili_SizeW_imageW;
            CGFloat height = width / bili_imageWH;
            CGFloat x = 0;
            CGFloat y = -(height - Size.height)/2;
            rect = CGRectMake(x,y,
                              width,
                              height);
        }
    }
    
    [[UIColor clearColor] set];
    UIRectFill(rect);
    
    [OldImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


@end
