//
//  SIGCDMacro.h
//  Category
//
//  Created by Silence on 25/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

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

// Block
#define GCDBackground(block)          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDMain(block)                dispatch_async(dispatch_get_main_queue(),block)
#define GCDAfter(sec, block)          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), block)
#define GCDOnce(block)                static dispatch_once_t onceToken; dispatch_once(&onceToken, block);
#define SyncQueue(Queue, block)       dispatch_sync(Queue, block)
#define AsyncQueue(Queue, block)      dispatch_async(Queue, block)
#define GlobalQueue(block)            Async_Queue(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
