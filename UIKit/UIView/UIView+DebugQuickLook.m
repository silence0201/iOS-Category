//
//  UIView+DebugQuickLook.m
//  Category
//  https://github.com/Inferis/UIView-DebugQuickLook
//  Created by 杨晴贺 on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIView+DebugQuickLook.h"
#import <objc/runtime.h>

@implementation UIView (DebugQuickLook)

#ifdef DEBUG
+ (void)insert_debugQuickLookObject
{
    SEL debugQuickLookObject = NSSelectorFromString(@"debugQuickLookObject");
    // dont add it if it's already there
    if ([self instancesRespondToSelector:debugQuickLookObject]) {
        return;
    }
    
    SEL image_debugQuickLookObject = @selector(image_debugQuickLookObject);
    IMP imp = class_getMethodImplementation(self, image_debugQuickLookObject);
    const char* encoding = method_getTypeEncoding(class_getClassMethod(self, image_debugQuickLookObject));
    BOOL ok = class_addMethod(self, debugQuickLookObject, imp, encoding);
    if (ok) {
        NSLog(@"added debugQuickLookObject support to UIView.");
    }
    else {
        NSLog(@"Could not add debugQuickLookObject support to UIView. Bummer.");
    }
}

- (id)image_debugQuickLookObject
{
    if (self.bounds.size.width == 0 || self.bounds.size.height == 0)
        return nil;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    if (![self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES])
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (void)load {
    @autoreleasepool {
        [self insert_debugQuickLookObject];
    }
}

#endif

@end
