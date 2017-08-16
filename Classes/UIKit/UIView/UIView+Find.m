//
//  UIView+Find.m
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIView+Find.h"

@implementation UIView (Find)

- (UIView *)findSubViewWithClass:(Class)clazz;{
    for (UIView * subView in self.subviews){
        if ([subView isKindOfClass:clazz]){
            return subView;
        }
    }
    return nil;
}

- (NSArray *)findAllSubViewsWithClass:(Class)clazz{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView * subView in self.subviews){
        if ([subView isKindOfClass:clazz]){
            [array addObject:subView];
        }
    }
    return array;
}

- (UIViewController *)viewController{
    UIResponder *responder = self.nextResponder;
    do{
        if ([responder isKindOfClass:[UIViewController class]]){
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    while (responder);
    return nil;
}

- (NSArray *)allSubviews{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [array addObjectsFromArray:self.subviews];
    for (UIView *view in self.subviews){
        [array addObjectsFromArray:[view allSubviews]];
    }
    return array;
}

- (void)removeAllSubviews{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (UIView *)findFirstResponder{
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder)){
        return self;
    }
    
    for (UIView *v in self.subviews){
        UIView *fv = [v findFirstResponder];
        if (fv){
            return fv;
        }
    }
    return nil;
}

@end
