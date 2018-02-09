//
//  UIViewController+KeyboardAnimation.m
//  Category
//
//  Created by Silence on 2018/2/9.
//  Copyright © 2018年 silence. All rights reserved.
//

#import "UIViewController+KeyboardAnimation.h"
#import <objc/runtime.h>

static void *SIFrameChangesAnimationsBlockAssociationKey = &SIFrameChangesAnimationsBlockAssociationKey;
static void *SIAnimationsBlockAssociationKey = &SIAnimationsBlockAssociationKey;
static void *SIBeforeAnimationsBlockAssociationKey = &SIBeforeAnimationsBlockAssociationKey;
static void *SIAnimationsCompletionBlockAssociationKey = &SIAnimationsCompletionBlockAssociationKey;

@implementation UIViewController (KeyboardAnimation)

#pragma mark public
- (void)subscribeKeyboardFrameChangesWithAnimations:(SIFrameChangesAnimationsWithKeyboardBlock)animations {
    objc_setAssociatedObject(self, SIFrameChangesAnimationsBlockAssociationKey, animations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillChageFrameKeyboardNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}


- (void)subscribeKeyboardWithAnimations:(SIAnimationsWithKeyboardBlock)animations
                             completion:(SICompletionKeyboardAnimations)completion {
    [self subscribeKeyboardWithBeforeAnimations:nil animations:animations completion:completion];
}

- (void)subscribeKeyboardWithBeforeAnimations:(SIBeforeAnimationsWithKeyboardBlock)beforeAnimations
                                   animations:(SIAnimationsWithKeyboardBlock)animations
                                   completion:(SICompletionKeyboardAnimations)completion {
    objc_setAssociatedObject(self, SIBeforeAnimationsBlockAssociationKey, beforeAnimations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, SIAnimationsBlockAssociationKey, animations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, SIAnimationsCompletionBlockAssociationKey, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillShowKeyboardNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleWillHideKeyboardNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

#pragma mark unsubscribe

- (void)unsubscribeKeyboard {
    objc_setAssociatedObject(self, SIBeforeAnimationsBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, SIAnimationsBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, SIAnimationsCompletionBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)unsubscribeKeyboardFrameChanges {
    objc_setAssociatedObject(self, SIFrameChangesAnimationsBlockAssociationKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark private
- (void)handleWillChageFrameKeyboardNotification:(NSNotification *)notification {
    CGRect keyboardRect = [self getKeyboardRectFromNotification:notification];
    UIViewAnimationCurve curve = [self getAnimationCurveFromNotification:notification];
    NSTimeInterval duration = [self getDurationFromNotification:notification];
    
    SIFrameChangesAnimationsWithKeyboardBlock animationsBlock = objc_getAssociatedObject(self, SIFrameChangesAnimationsBlockAssociationKey);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [UIView setAnimationCurve:curve];
                         if (animationsBlock) animationsBlock(keyboardRect, duration);
                     }
                     completion:nil];
}

- (void)handleWillShowKeyboardNotification:(NSNotification *)notification {
    [self keyboardWillShowHide:notification isShowing:YES];
}

- (void)handleWillHideKeyboardNotification:(NSNotification *)notification {
    [self keyboardWillShowHide:notification isShowing:NO];
}

- (void)keyboardWillShowHide:(NSNotification *)notification isShowing:(BOOL)isShowing {
    CGRect keyboardRect = [self getKeyboardRectFromNotification:notification];
    UIViewAnimationCurve curve = [self getAnimationCurveFromNotification:notification];
    NSTimeInterval duration = [self getDurationFromNotification:notification];
    
    SIAnimationsWithKeyboardBlock animationsBlock = objc_getAssociatedObject(self, SIAnimationsBlockAssociationKey);
    SIBeforeAnimationsWithKeyboardBlock beforeAnimationsBlock = objc_getAssociatedObject(self, SIBeforeAnimationsBlockAssociationKey);
    SICompletionKeyboardAnimations completionBlock = objc_getAssociatedObject(self, SIAnimationsCompletionBlockAssociationKey);
    
    if (beforeAnimationsBlock) beforeAnimationsBlock(keyboardRect, duration, isShowing);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [UIView setAnimationCurve:curve];
                         if (animationsBlock) animationsBlock(keyboardRect, duration, isShowing);
                     }
                     completion:completionBlock];
}

- (CGRect)getKeyboardRectFromNotification:(NSNotification *)notification {
    return [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
}

- (UIViewAnimationCurve)getAnimationCurveFromNotification:(NSNotification *)notification {
    return [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
}

- (NSTimeInterval)getDurationFromNotification:(NSNotification *)notification {
    return [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
}


@end
