//
//  SIFPSManager.h
//  Category
//
//  Created by Silence on 2017/12/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIFPSManager : UIWindow

+ (SIFPSManager *)sharedManager;

- (void)open;
- (void)close;

@end
