//
//  SIFPSManager.h
//  Category
//
//  Created by 杨晴贺 on 2017/12/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIFPSManager : UIWindow

+ (SIFPSManager *)sharedInstance;

- (void)open;
- (void)close;

@end
