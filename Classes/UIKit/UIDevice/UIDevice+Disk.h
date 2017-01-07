//
//  UIDevice+Disk.h
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Disk)

@property (nonatomic,readonly) int64_t diskSpace;
@property (nonatomic,readonly) int64_t diskSpaceFree;
@property (nonatomic,readonly) int64_t diskSpaceUsed;

@property (nonatomic, readonly) int64_t memoryTotal;
@property (nonatomic, readonly) int64_t memoryUsed;
@property (nonatomic, readonly) int64_t memoryFree;
@property (nonatomic, readonly) int64_t memoryActive;
@property (nonatomic, readonly) int64_t memoryInactive;
@property (nonatomic, readonly) int64_t memoryWired;
@property (nonatomic, readonly) int64_t memoryPurgable;

@end
