//
//  SIKeyboardShortcutManager.m
//  KeyboardShortcutManagerDemo
//
//  Created by 杨晴贺 on 19/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "SIKeyboardShortcutManager.h"
#import <objc/message.h>

// https://github.com/silence0201/Headers/blob/ab28eba3cd027298bc4689972179226e1440148a/iOS10/Frameworks/UIKit/UIPhysicalKeyboardEvent.h

#if TARGET_OS_SIMULATOR
@interface UIEvent (UIPhysicalKeyboardEvent)

@property (nonatomic,strong) NSString *_modifiedInput;
@property (nonatomic,strong) NSString *_unmodifiedInput;
@property (nonatomic,assign) UIKeyModifierFlags _modifierFlags;
@property (nonatomic,assign) BOOL _isKeyDown;
@property (nonatomic,assign) long _keyCode;

@end

@interface _KeyInput : NSObject<NSCopying>

@property (nonatomic,copy,readonly) NSString *key;
@property (nonatomic,assign,readonly) UIKeyModifierFlags flags;

@end

@implementation _KeyInput

- (BOOL)isEqual:(id)object{
    BOOL isEqual = NO;
    if ([object isKindOfClass:[_KeyInput class]]) {
        _KeyInput *keyCommand = (_KeyInput *)object;
        BOOL equalKeys = self.key == keyCommand.key || [self.key isEqual:keyCommand.key];
        BOOL equalFlags = self.flags == keyCommand.flags;
        isEqual = equalKeys && equalFlags;
    }
    return isEqual;
}

- (NSUInteger)hash{
    return [self.key hash] ^ self.flags;
}

- (instancetype)copyWithZone:(NSZone *)zone{
    return [[self class] keyInputForKey:self.key flags:self.flags];
}


+ (instancetype)keyInputForKey:(NSString *)key flags:(UIKeyModifierFlags)flags{
    _KeyInput *keyInput = [[self alloc] init];
    if (keyInput) {
        keyInput->_key = key;
        keyInput->_flags = flags;
    }
    return keyInput;
}

@end

static const long kSIControlKeyCode = 0xe0;
static const long kSIShiftKeyCode = 0xe1;
static const long kSICommandKeyCode = 0xe3;

@interface SIKeyboardShortcutManager ()

@property (nonatomic,strong) NSMutableDictionary *actionsForKeyInput ;

@property (nonatomic,assign,getter=isPressingShift) BOOL pressingShift ;
@property (nonatomic,assign,getter=isPressingCommand) BOOL pressingCommand ;
@property (nonatomic,assign,getter=isPressingControl) BOOL pressingControl ;

@end

@implementation SIKeyboardShortcutManager

// 加载时交换方法
+ (void)load{
    SEL originalKeyEventSelector = NSSelectorFromString(@"handleKeyUIEvent:");
    SEL swizzledKeyEventSelector = [SIKeyboardShortcutManager swizzledSelectorForSelector:originalKeyEventSelector];
    
    void (^handleKeyUIEventSwizzleBlock)(UIApplication *, UIEvent *) = ^(UIApplication *slf, UIEvent *event) {
        [[[self class] sharedManager] handleKeyboardEvent:event];
        ((void(*)(id, SEL, id))objc_msgSend)(slf, swizzledKeyEventSelector, event);
    };
    
    [SIKeyboardShortcutManager replaceImplementationOfKnownSelector:originalKeyEventSelector
                                                              onClass:[UIApplication class]
                                                            withBlock:handleKeyUIEventSwizzleBlock
                                                     swizzledSelector:swizzledKeyEventSelector];
    
    if ([[UITouch class] instancesRespondToSelector:@selector(maximumPossibleForce)]) {
        SEL originalSendEventSelector = NSSelectorFromString(@"sendEvent:");
        SEL swizzledSendEventSelector = [SIKeyboardShortcutManager swizzledSelectorForSelector:originalSendEventSelector];
        
        void (^sendEventSwizzleBlock)(UIApplication *, UIEvent *) = ^(UIApplication *slf, UIEvent *event) {
            if (event.type == UIEventTypeTouches) {
                SIKeyboardShortcutManager *keyboardManager = [SIKeyboardShortcutManager sharedManager];
                NSInteger pressureLevel = 0;
                if (keyboardManager.isPressingShift) {
                    pressureLevel++;
                }
                if (keyboardManager.isPressingCommand) {
                    pressureLevel++;
                }
                if (keyboardManager.isPressingControl) {
                    pressureLevel++;
                }
                if (pressureLevel > 0) {
                    for (UITouch *touch in [event allTouches]) {
                        double adjustedPressureLevel = pressureLevel * 20 * touch.maximumPossibleForce;
                        [touch setValue:@(adjustedPressureLevel) forKey:@"_pressure"];
                    }
                }
            }
            
            ((void(*)(id, SEL, id))objc_msgSend)(slf, swizzledSendEventSelector, event);
        };
        
        [SIKeyboardShortcutManager replaceImplementationOfKnownSelector:originalSendEventSelector
                                                                  onClass:[UIApplication class]
                                                                withBlock:sendEventSwizzleBlock
                                                         swizzledSelector:swizzledSendEventSelector];
        
        SEL originalSupportsTouchPressureSelector = NSSelectorFromString(@"_supportsForceTouch");
        SEL swizzledSupportsTouchPressureSelector = [SIKeyboardShortcutManager swizzledSelectorForSelector:originalSupportsTouchPressureSelector];
        
        BOOL (^supportsTouchPressureSwizzleBlock)(UIDevice *) = ^BOOL(UIDevice *slf) {
            return YES;
        };
        
        [SIKeyboardShortcutManager replaceImplementationOfKnownSelector:originalSupportsTouchPressureSelector
                                                                onClass:[UIDevice class]
                                                              withBlock:supportsTouchPressureSwizzleBlock
                                                       swizzledSelector:swizzledSupportsTouchPressureSelector];
    }
}


+ (instancetype)sharedManager{
    static SIKeyboardShortcutManager *sharedManager = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init] ;
    });
    return sharedManager ;
}

- (instancetype)init{
    if(self = [super init]){
        _actionsForKeyInput = [NSMutableDictionary dictionary] ;
        _enabled = YES ;
    }
    return self ;
}

- (void)registerSimulatorShortcutWithKey:(NSString *)key modifiers:(UIKeyModifierFlags)modifiers action:(KeyBoardAction)action{
    _KeyInput *keyInput = [_KeyInput keyInputForKey:key flags:modifiers] ;
    [self.actionsForKeyInput setObject:action forKey:keyInput] ;
}

- (void)handleKeyboardEvent:(UIEvent *)event{
    if (!self.enabled)  return ;
    
    NSString *modifiedInput = nil;
    NSString *unmodifiedInput = nil;
    UIKeyModifierFlags flags = 0;
    BOOL isKeyDown = NO;
    
    if ([event respondsToSelector:@selector(_modifiedInput)]) {
        modifiedInput = [event _modifiedInput] ;
    }
    
    if ([event respondsToSelector:@selector(_unmodifiedInput)]){
        unmodifiedInput = [event _unmodifiedInput] ;
    }
    
    if ([event respondsToSelector:@selector(_modifierFlags)]){
        flags = [event _modifierFlags] ;
    }
    
    if ([event respondsToSelector:@selector(_isKeyDown)]){
        isKeyDown = [event _isKeyDown] ;
    }
    
    BOOL interactionEnabled = ![[UIApplication sharedApplication] isIgnoringInteractionEvents];
    BOOL hasFirstResponder = NO;
    if (isKeyDown && [modifiedInput length] > 0 && interactionEnabled) {
        UIResponder *firstResponder = nil;
        for (UIWindow *window in [SIKeyboardShortcutManager allWindows]) {
            firstResponder = [window valueForKey:@"firstResponder"];
            if (firstResponder) {
                hasFirstResponder = YES;
                break;
            }
        }
        
        if (firstResponder) {
            if ([unmodifiedInput isEqual:UIKeyInputEscape]) {
                [firstResponder resignFirstResponder];
            }
        } else {
            _KeyInput *exactMatch = [_KeyInput keyInputForKey:unmodifiedInput flags:flags];
            KeyBoardAction actionBlock = self.actionsForKeyInput[exactMatch];
            
            if (!actionBlock) {
                _KeyInput *shiftMatch = [_KeyInput keyInputForKey:modifiedInput flags:flags&(!UIKeyModifierShift)];
                actionBlock = self.actionsForKeyInput[shiftMatch];
            }
            
            if (!actionBlock) {
                _KeyInput *capitalMatch = [_KeyInput keyInputForKey:[unmodifiedInput uppercaseString] flags:flags];
                actionBlock = self.actionsForKeyInput[capitalMatch];
            }
            
            if (actionBlock) {
                actionBlock();
            }
        }
    }
    
    if (!hasFirstResponder && [event respondsToSelector:@selector(_keyCode)]) {
        long keyCode = [event _keyCode];
        if (keyCode == kSIControlKeyCode) {
            self.pressingControl = isKeyDown;
        } else if (keyCode == kSICommandKeyCode) {
            self.pressingCommand = isKeyDown;
        } else if (keyCode == kSIShiftKeyCode) {
            self.pressingShift = isKeyDown;
        }
    }
}

#pragma mark Utils

+ (NSArray *)allWindows{
    BOOL includeInternalWindows = YES;
    BOOL onlyVisibleWindows = NO;
    
    NSArray *allWindowsComponents = @[@"al", @"lWindo", @"wsIncl", @"udingInt", @"ernalWin", @"dows:o", @"nlyVisi", @"bleWin", @"dows:"];
    SEL allWindowsSelector = NSSelectorFromString([allWindowsComponents componentsJoinedByString:@""]);
    
    NSMethodSignature *methodSignature = [[UIWindow class] methodSignatureForSelector:allWindowsSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    
    invocation.target = [UIWindow class];
    invocation.selector = allWindowsSelector;
    [invocation setArgument:&includeInternalWindows atIndex:2];
    [invocation setArgument:&onlyVisibleWindows atIndex:3];
    [invocation invoke];
    
    __unsafe_unretained NSArray *windows = nil;
    [invocation getReturnValue:&windows];
    return windows;
}

+ (SEL)swizzledSelectorForSelector:(SEL)selector{
    return NSSelectorFromString([NSString stringWithFormat:@"_si_swizzle_%x_%@", arc4random(), NSStringFromSelector(selector)]);
}

+ (void)replaceImplementationOfKnownSelector:(SEL)originalSelector onClass:(Class)class withBlock:(id)block swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    if (!originalMethod) {
        return;
    }
    
    IMP implementation = imp_implementationWithBlock(block);
    class_addMethod(class, swizzledSelector, implementation, method_getTypeEncoding(originalMethod));
    Method newMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, newMethod);
}

@end
#endif
