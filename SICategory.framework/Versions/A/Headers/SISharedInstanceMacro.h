//
//  SISharedInstanceMacro.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// 单例类声明
#define SHARED_INSTANCE_PROTO + (instancetype)sharedInstance;

// 单例类实现
#define SHARED_INSTANCE_IMPL \
+ (instancetype)sharedInstance {	return sharedInstance; }

#define SHARED_INSTANCE(class) \
__strong static class *sharedInstance; \
+ (void)initialize { \
@synchronized(self) { \
if (sharedInstance) \
return;	\
sharedInstance = [[class alloc] init]; \
\
[NOTIFICATION_CENTER addObserver:sharedInstance \
selector:@selector(singletonApplicationWillTerminate:) \
name:UIApplicationWillTerminateNotification \
object:nil]; \
} \
} \
\
- (void)singletonApplicationWillTerminate:(NSNotification*)notification { \
sharedInstance = nil; \
}


// Shared instance with terminate method terminate
#define SHARED_INSTANCE_TERMINATE(class, terminateSelector) \
static class *sharedInstance; \
+ (void)initialize { \
@synchronized(self) { \
if (!sharedInstance) \
sharedInstance = [[class alloc] init]; \
\
[NOTIFICATION_CENTER addObserver:sharedInstance \
selector:@selector(singletonApplicationWillTerminate:) \
name:UIApplicationWillTerminateNotification \
object:nil]; \
} \
} \
\
- (void)singletonApplicationWillTerminate:(NSNotification*)notification { \
sharedInstance = nil; \
[self performSelector:terminateSelector]; \
}
