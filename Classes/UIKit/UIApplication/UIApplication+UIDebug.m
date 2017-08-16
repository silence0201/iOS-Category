//
//  UIApplication+UIDebug.m
//  Category
//
//  Created by Silence on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIApplication+UIDebug.h"

@implementation UIApplication (UIDebug)

+ (void)showDebuggingInformationOverlay {
#if DEBUG
    Class overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    SEL overlay = NSSelectorFromString(@"overlay");
    SEL toggleVisibility = NSSelectorFromString(@"toggleVisibility") ;
    SEL prepareDebuggingOverlay = NSSelectorFromString(@"prepareDebuggingOverlay") ;
    if ([overlayClass respondsToSelector:prepareDebuggingOverlay]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [overlayClass performSelector:prepareDebuggingOverlay] ;
        id obj = [overlayClass performSelector:overlay];
        [obj performSelector:toggleVisibility] ;
#pragma clang diagnostic pop
    }
    
#endif
}

@end
