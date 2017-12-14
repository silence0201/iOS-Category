//
//  UIApplication+UIDebug.m
//  Category
//
//  Created by Silence on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIApplication+UIDebug.h"

#import <objc/runtime.h>


/*
 In iOS 11, Apple added additional checks to disable this overlay unless the
 device is an internal device. To get around this, we swizzle out the
 -[UIDebuggingInformationOverlay init] method (which returns nil now if
 the device is non-internal) and +[UIDebuggingInformationOverlay prepareDebuggingOverlay]
 method.
 
 Usage:
 1.Copy this file to your project.
 2.Add the following code to [AppDelegate application:didFinishLaunchingWithOptions:]
 
 #if DEBUG
 id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
 [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
 #endif
 
 */


#if defined(DEBUG) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface UIWindow (PrivateMethods)
- (void)_setWindowControlsStatusBarOrientation:(BOOL)orientation;
@end

@interface FakeWindowClass : UIWindow
@end

@implementation FakeWindowClass

- (instancetype)initSwizzled {
    self = [super init];
    if (self) {
        [self _setWindowControlsStatusBarOrientation:NO];
    }
    return self;
}

@end

@implementation NSObject (UIDebuggingInformationOverlayEnable)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"UIDebuggingInformationOverlay");
        [FakeWindowClass swizzleSelector:@selector(init) newSelector:@selector(initSwizzled) forClass:cls isClassMethod:NO];
        [self swizzleSelector:@selector(prepareDebuggingOverlay) newSelector:@selector(prepareDebuggingOverlaySwizzled) forClass:cls isClassMethod:YES];
    });
}

+ (void)swizzleSelector:(SEL)originalSelector newSelector:(SEL)swizzledSelector forClass:(Class)class isClassMethod:(BOOL)isClassMethod {
    Method originalMethod = NULL;
    Method swizzledMethod = NULL;
    
    if (isClassMethod) {
        originalMethod = class_getClassMethod(class, originalSelector);
        swizzledMethod = class_getClassMethod([self class], swizzledSelector);
    } else {
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    }
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)prepareDebuggingOverlaySwizzled {
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlayInvokeGestureHandler");
    id handler = [overlayClass performSelector:NSSelectorFromString(@"mainHandler")];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:handler action:@selector(_handleActivationGesture:)];
    tapGesture.numberOfTouchesRequired = 2;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = handler;
    
    UIView *statusBarWindow = [[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
    [statusBarWindow addGestureRecognizer:tapGesture];
}

@end

@interface OverlayWindow : UIWindow
- (UIGestureRecognizerState)state;
@end

@implementation OverlayWindow
- (UIGestureRecognizerState)state {
    return UIGestureRecognizerStateEnded;
}
@end
#pragma clang diagnostic pop

#endif

@implementation UIApplication (UIDebug)

+ (void)showDebuggingInformationOverlay {
#if DEBUG
    Class overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    SEL prepareDebuggingOverlay = NSSelectorFromString(@"prepareDebuggingOverlay") ;
    if ([overlayClass respondsToSelector:prepareDebuggingOverlay]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (@available(iOS 11.0, *)) {
            // Simulate two finger click status bar events
            // 模拟两个手指点击状态栏的事件
            id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
            [overlayClass performSelector:NSSelectorFromString(@"overlay")];
            id handlerClass = NSClassFromString(@"UIDebuggingInformationOverlayInvokeGestureHandler");
            
            id handler = [handlerClass performSelector:NSSelectorFromString(@"mainHandler")];
            [handler performSelector:NSSelectorFromString(@"_handleActivationGesture:") withObject:[[OverlayWindow alloc] init]];
        } else {
            id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
            id overlay = [overlayClass performSelector:NSSelectorFromString(@"overlay")];
            [overlay performSelector:NSSelectorFromString(@"toggleVisibility")];
        }
#pragma clang diagnostic pop
    }
    
#endif
}

@end
