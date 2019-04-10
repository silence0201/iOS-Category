//
//  UIControl+Sound.h
//  Category
//
//  Created by Silence on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Sound)

/// 不同事件增加不同声音
- (void)setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent;

@end
