//
//  UIImage+GIF.m
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIImage+GIF.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (GIF)

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i){
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties){
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties){
            NSNumber *number = (__bridge id) CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0){
                number = (__bridge id) CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0){
                delayCentiseconds = (int)lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]){
    for (size_t i = 0; i < count; ++i){
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values){
    int theSum = 0;
    for (size_t i = 0; i < count; ++i){
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b){
    if (a < b){
        return pairGCD(b, a);
    }
    while (true){
        int const r = a % b;
        if (r == 0){
            return b;
        }
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values){
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i){
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds){
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i){
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j){
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]){
    for (size_t i = 0; i < count; ++i){
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source){
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source){
    if (source){
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    }else{
        return nil;
    }
}

+ (UIImage *)animatedImageWithAnimatedGIFData:(NSData *)data{
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData((__bridge CFTypeRef) data, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url{
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL((__bridge CFTypeRef) url, NULL));
}

+ (UIImage *)animatedImageWithAnimatedGIFNamed:(NSString *)name{
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [UIImage animatedImageWithAnimatedGIFData:data];
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [UIImage animatedImageWithAnimatedGIFData:data];
        }
        return [UIImage imageNamed:name];
    }else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            return [UIImage animatedImageWithAnimatedGIFData:data];
        }
        return [UIImage imageNamed:name];
    }
}

- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size{
    if (CGSizeEqualToSize(self.size, size) || CGSizeEqualToSize(size, CGSizeZero)) {
        return self;
    }
    CGSize scaledSize = size;
    CGPoint thumbnailPoint = CGPointZero;
    CGFloat widthFactor = size.width / self.size.width;
    CGFloat heightFactor = size.height / self.size.height;
    CGFloat scaleFactor = (widthFactor > heightFactor) ? widthFactor : heightFactor;
    scaledSize.width = self.size.width * scaleFactor;
    scaledSize.height = self.size.height * scaleFactor;
    if (widthFactor > heightFactor) {
        thumbnailPoint.y = (size.height - scaledSize.height) * 0.5;
    }
    else if (widthFactor < heightFactor) {
        thumbnailPoint.x = (size.width - scaledSize.width) * 0.5;
    }
    NSMutableArray *scaledImages = [NSMutableArray array];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    for (UIImage *image in self.images) {
        [image drawInRect:CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledSize.width, scaledSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        [scaledImages addObject:newImage];
    }
    UIGraphicsEndImageContext();
    return [UIImage animatedImageWithImages:scaledImages duration:self.duration];
}

@end

@implementation GifFrame
@end

@interface GifDecoder()

@property (nonatomic, assign, readwrite) NSUInteger loopCount;

@end

@implementation GifDecoder{
    CGImageSourceRef _source;
    NSUInteger _frameCount; //!<动画帧数
}

+ (instancetype)decoderWithGIFNamed:(NSString *)name{
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        if (data) {
            return [GifDecoder decoderWithData:data];
        }
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [GifDecoder decoderWithData:data];
}

+ (instancetype)decoderWithData:(NSData *)data{
    if ( !data ) return nil;
    
    GifDecoder *decoder = [[GifDecoder alloc] init];
    [decoder _decoderPrepareWithData:data];
    return decoder;
}

- (void)dealloc{
    CFRelease(_source);
}

- (void)_decoderPrepareWithData:(NSData *)data{
    _source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    _frameCount = CGImageSourceGetCount(_source);
    
    CFDictionaryRef properties = CGImageSourceCopyProperties(_source, NULL);
    CFDictionaryRef gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
    CFTypeRef loop = CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFLoopCount);
    if (loop) CFNumberGetValue(loop, kCFNumberNSIntegerType, &_loopCount);
    CFRelease(properties);
}

- (GifFrame *)frameAtIndex:(NSUInteger)index{
    if ( index >= _frameCount ) return nil;
    
    GifFrame *frame = [[GifFrame alloc] init];
    frame.index = index;
    
    NSTimeInterval duration = 0;
    CFDictionaryRef frameProperties = CGImageSourceCopyPropertiesAtIndex(_source, index, NULL);
    CFDictionaryRef gifFrameProperties = CFDictionaryGetValue(frameProperties, kCGImagePropertyGIFDictionary);
    CFTypeRef delayTime = CFDictionaryGetValue(gifFrameProperties, kCGImagePropertyGIFDelayTime);
    if(delayTime) CFNumberGetValue(delayTime, kCFNumberDoubleType, &duration);
    CFRelease(frameProperties);
    frame.duration = duration;
    
    CGImageRef cgImage = CGImageSourceCreateImageAtIndex(_source, index, NULL);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    frame.image = image;
    CFRelease(cgImage);
    
    return frame;
}

- (NSArray<GifFrame*>*)contentImages{
    if (!_source) {
        return nil;
    }
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:_frameCount];
    for (NSInteger i=0; i<_frameCount; i++) {
        GifFrame *gifFrame = [self frameAtIndex:i];
        [images addObject:gifFrame];
    }
    return images;
}


#pragma mark - views
- (UIImage *)gifImage{
    if (!_source) {
        return nil;
    }
    
    NSTimeInterval duration = 0;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:_frameCount];
    for (NSInteger i=0; i<_frameCount; i++) {
        GifFrame *gifFrame = [self frameAtIndex:i];
        [images addObject:gifFrame.image];
        
        duration += gifFrame.duration;
    }
    
    UIImage *gifImage = [UIImage animatedImageWithImages:images duration:duration];
    return gifImage;
}




@end
