//
//  SISharedInstanceMacro.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

/** Shared instances **/
// Shared instance class declaration
#define SHARED_INSTANCE_PROTO + (instancetype)sharedInstance;

// Shared instance class implementation
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

// SHARED_INSTANCE_GCD
#ifndef SHARED_INSTANCE_GCD
#define SHARED_INSTANCE_GCD \
\
+ (instancetype)sharedInstance { \
DEFINE_SHARED_INSTANCE_GCD_USING_BLOCK(^{ \
return [[self alloc] init]; \
}) \
}
#endif

#ifndef SHARED_INSTANCE_GCD_USING_BLOCK
#define SHARED_INSTANCE_GCD_USING_BLOCK(block) \
\
+ (instancetype)sharedInstance { \
DEFINE_SHARED_INSTANCE_GCD_USING_BLOCK(block) \
}
#endif

#ifndef SHARED_INSTANCE_GCD_WITH_NAME
#define SHARED_INSTANCE_GCD_WITH_NAME(classname)                        \
\
+ (instancetype)shared##classname { \
DEFINE_SHARED_INSTANCE_GCD_USING_BLOCK(^{ \
return [[self alloc] init]; \
}) \
}
#endif

#ifndef SHARED_INSTANCE_GCD_WITH_NAME_USING_BLOCK
#define SHARED_INSTANCE_GCD_WITH_NAME_USING_BLOCK(classname, block) \
\
+ (instancetype)shared##classname { \
DEFINE_SHARED_INSTANCE_GCD_USING_BLOCK(block) \
}
#endif

#ifndef DEFINE_SHARED_INSTANCE_GCD_USING_BLOCK
#define DEFINE_SHARED_INSTANCE_GCD_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject;
#endif

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
