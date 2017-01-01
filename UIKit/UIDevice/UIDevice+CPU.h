//
//  UIDevice+CPU.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CPU)

@property (nonatomic,readonly) NSUInteger cpuNumber ;
@property (nonatomic,readonly) NSUInteger cpuFrequency ;
@property (nonatomic,readonly) NSUInteger busFrequency ;

@property (nonatomic,readonly) float cpuUsage ;
@property (nonatomic,readonly) NSArray<NSNumber *> *cpuUsagePerProcessor ;

@end
