//
//  SIFPSManager.m
//  Category
//
//  Created by Silence on 2017/12/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "SIFPSManager.h"

@implementation SIFPSManager{
    CADisplayLink   *_displayLink;
    CATextLayer     *_fpsTextLayer;
    NSTimeInterval  _lastTime;
    NSUInteger      _count;
}

+ (instancetype)sharedInstance {
    static SIFPSManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    if (self = [super init]) {
        self.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-50)/2+50, 0, 50, 20);
        self.windowLevel = UIWindowLevelStatusBar + 100;
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
            self.rootViewController = [UIViewController new];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActiveNotification)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        _fpsTextLayer = [CATextLayer layer];
        [_fpsTextLayer setFrame:CGRectMake(20, 3, self.bounds.size.width-20, self.bounds.size.height-3)];
        [_fpsTextLayer setFontSize: 12.0f];
        [_fpsTextLayer setContentsScale: [UIScreen mainScreen].scale];
        [_fpsTextLayer setBackgroundColor:[UIColor clearColor].CGColor];
        [_fpsTextLayer setForegroundColor: [UIColor greenColor].CGColor];
        [_fpsTextLayer setAlignmentMode:kCAAlignmentLeft];
        [self.layer addSublayer:_fpsTextLayer];
    }
    return self;
}

- (void)displayLinkTick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval interval = link.timestamp - _lastTime;
    if (interval < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / interval;
    _count = 0;
    
    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    [_fpsTextLayer setString: text];
    
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    [_fpsTextLayer setForegroundColor:color.CGColor];
}

- (void)open {
    self.hidden = NO;
    [_displayLink setPaused:NO];
}


- (void)close {
    self.hidden = YES;
    [_displayLink setPaused:YES];
}

- (void)applicationDidBecomeActiveNotification {
    [_displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification {
    [_displayLink setPaused:YES];
}

- (void)becomeKeyWindow {
    [self setHidden: YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setHidden: NO];
    });
}

- (void)dealloc {
    [_displayLink setPaused:YES];
    [_displayLink invalidate];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}
@end
