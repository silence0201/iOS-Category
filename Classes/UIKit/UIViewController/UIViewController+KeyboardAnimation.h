//
//  UIViewController+KeyboardAnimation.h
//  Category
//
//  Created by Silence on 2018/2/9.
//  Copyright © 2018年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SIAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);
typedef void(^SIFrameChangesAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration);
typedef void(^SIBeforeAnimationsWithKeyboardBlock)(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing);
typedef void(^SICompletionKeyboardAnimations)(BOOL finished);

@interface UIViewController (KeyboardAnimation)

- (void)subscribeKeyboardWithAnimations:(SIAnimationsWithKeyboardBlock)animations
                             completion:(SICompletionKeyboardAnimations)completion;

- (void)subscribeKeyboardWithBeforeAnimations:(SIBeforeAnimationsWithKeyboardBlock)beforeAnimations
                                   animations:(SIAnimationsWithKeyboardBlock)animations
                                   completion:(SICompletionKeyboardAnimations)completion;

- (void)subscribeKeyboardFrameChangesWithAnimations:(SIFrameChangesAnimationsWithKeyboardBlock)animations;

- (void)unsubscribeKeyboard;
- (void)unsubscribeKeyboardFrameChanges;

@end
