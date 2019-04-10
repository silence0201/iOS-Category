//
//  SICallStackManager.h
//  Category
//
//  Created by Silence on 2018/3/9.
//  Copyright © 2018年 silence. All rights reserved.
//  https://github.com/bestswifter/BSBacktraceLogger

#import <Foundation/Foundation.h>

#define CSLOG        NSLog(@"%@",[SICallStackManager callStackOfCurrentThread]);
#define CSLOG_MAIN   NSLog(@"%@",[SICallStackManager callStackOfMainThread]);
#define CSLOG_ALL    NSLog(@"%@",[SICallStackManager callStackOfAllThread]);

@interface SICallStackManager : NSObject

+ (NSString *)callStackOfAllThread;
+ (NSString *)callStackOfCurrentThread;
+ (NSString *)callStackOfMainThread;
+ (NSString *)callStackOfNSThread:(NSThread *)thread;

@end
