//
//  UIView+Border.m
//  Category
//  https://github.com/cknessaj/UIView-Border
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIView+Border.h"
#import <objc/runtime.h>

#pragma mark -
#pragma mark - NSBorderItem

@implementation NSBorderItem
- (UIColor *)borderColor {
    if (!_borderColor) {
        return [[UIColor grayColor] colorWithAlphaComponent:.5];
    }
    return _borderColor;
}
- (CGFloat)borderWidth {
    return MAX(_borderWidth, 0.1);
}
@end

#pragma mark -
#pragma mark - UIMBorderView

@interface UIMBorderView : UIView

@property (nonatomic, strong) NSArray<NSBorderItem *> *borderItems;

@property (nonatomic, assign) UIViewBorderType mBordertype;
@property (nonatomic, strong) UIColor *mColorBorder;
@property (nonatomic, assign) CGFloat mBorderWidth;
@end
@implementation UIMBorderView

- (void)setMBorderWidth:(CGFloat)mBorderWidth {
    if (_mBorderWidth != mBorderWidth) {
        _mBorderWidth = mBorderWidth;
        [self setNeedsDisplay];
    }
}
- (void)setMColorBorder:(UIColor *)mColorBorder {
    _mColorBorder = mColorBorder;
    [self setNeedsDisplay];
}

- (void)setMBordertype:(UIViewBorderType)mBordertype {
    if (_mBordertype != mBordertype) {
        _mBordertype = mBordertype;
        [self setNeedsDisplay];
    }
}

- (void)setBorderItems:(NSArray<NSBorderItem *> *)borderItems {
    _borderItems = borderItems;
    [self setNeedsDisplay];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_borderItems.count) {
        [self drawEachLineRect:rect];
    }else {
        [self drawSampleLineRect:rect];
    }
}

- (NSBorderItem *)itemFromType:(UIViewBorderType)type {
    for (NSBorderItem* item in _borderItems) {
        if (item.borderType == type) {
            return item;
        }
    }
    return nil;
}

- (void)drawEachLineRect:(CGRect)rect {
    if ([self itemFromType:UIViewBorderTypeNone]) {
        return;
    }
    NSBorderItem *itemAll = [self itemFromType:UIViewBorderTypeAll];
    if (itemAll) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self configCGContextRef:context item:itemAll];
        CGContextAddRect(context, CGRectInset(rect, itemAll.borderWidth*0.5, itemAll.borderWidth*0.5));
        
        CGContextStrokePath(context);
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSBorderItem* item in _borderItems) {
        switch (item.borderType) {
            case UIViewBorderTypeTop: {
                [self configCGContextRef:context item:item];
                CGContextMoveToPoint(context, 0, _mBorderWidth*0.5);
                CGContextAddLineToPoint(context, rect.size.width, _mBorderWidth*0.5);
                CGContextStrokePath(context);
            }
                break;
            case UIViewBorderTypeBottom: {
                [self configCGContextRef:context item:item];
                CGContextMoveToPoint(context, rect.size.width, rect.size.height-_mBorderWidth*0.5);
                CGContextAddLineToPoint(context, 0, rect.size.height-_mBorderWidth*0.5);
                CGContextStrokePath(context);
            }
                break;
            case UIViewBorderTypeLeft: {
                [self configCGContextRef:context item:item];
                CGContextMoveToPoint(context, _mBorderWidth*0.5, rect.size.height);
                CGContextAddLineToPoint(context, _mBorderWidth*0.5, 0);
                CGContextStrokePath(context);
            }
                break;
            case UIViewBorderTypeRight: {
                [self configCGContextRef:context item:item];
                CGContextMoveToPoint(context, rect.size.width-_mBorderWidth*0.5, 0);
                CGContextAddLineToPoint(context, rect.size.width-_mBorderWidth*0.5, rect.size.height);
                CGContextStrokePath(context);
            }
                break;
            default:
                break;
        }
    }
}

- (void)configCGContextRef:(CGContextRef)context item:(NSBorderItem *)item {
    CGContextSetLineCap(context, item.lineCap);
    
    NSArray<NSNumber *> *array = item.lineDashPattern;
    NSInteger count = array.count;
    CGFloat *arrayFloat;
    arrayFloat = (CGFloat *) malloc(sizeof(CGFloat) * count);
    for (int index = 0; index < count; index++) {
        if (array.count > index) {
            arrayFloat[index] = [array[index] doubleValue];
        }
    }
    CGContextSetLineDash(context, item.lineDashPhase, arrayFloat, count);
    
    CGContextSetStrokeColorWithColor(context, item.borderColor.CGColor);
    CGContextSetLineWidth(context, item.borderWidth);
}

- (void)drawEachLineRect:(CGRect)rect item:(NSBorderItem *)item {
    
}

- (void)drawSampleLineRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _mBorderWidth);
    CGContextSetStrokeColorWithColor(context, _mColorBorder.CGColor);
    
    if (!(_mBordertype & UIViewBorderTypeNone)) {
        if ((_mBordertype & UIViewBorderTypeTop) || (_mBordertype & UIViewBorderTypeAll)) {
            CGContextMoveToPoint(context, 0, _mBorderWidth*0.5);
            CGContextAddLineToPoint(context, rect.size.width, _mBorderWidth*0.5);
        }
        if ((_mBordertype & UIViewBorderTypeRight) || (_mBordertype & UIViewBorderTypeAll)) {
            CGContextMoveToPoint(context, rect.size.width-_mBorderWidth*0.5, 0);
            CGContextAddLineToPoint(context, rect.size.width-_mBorderWidth*0.5, rect.size.height);
        }
        if ((_mBordertype & UIViewBorderTypeBottom) || (_mBordertype & UIViewBorderTypeAll)) {
            CGContextMoveToPoint(context, rect.size.width, rect.size.height-_mBorderWidth*0.5);
            CGContextAddLineToPoint(context, 0, rect.size.height-_mBorderWidth*0.5);
        }
        if ((_mBordertype & UIViewBorderTypeLeft) || (_mBordertype & UIViewBorderTypeAll)) {
            CGContextMoveToPoint(context, _mBorderWidth*0.5, rect.size.height);
            CGContextAddLineToPoint(context, _mBorderWidth*0.5, 0);
        }
    }
    CGContextStrokePath(context);
}

@end

#pragma mark -
#pragma mark - UIView (Border)

static const char *key_UIView_BorderView = "key_UIView_BorderView_mlib";
static const char *key_UIView_BorderType = "key_UIView_BorderType_mlib";
static const char *key_UIView_BorderEdge = "key_UIView_BorderEdge_mlib";

@interface UIView()
@property (nonatomic, strong) UIMBorderView *borderView;
@end

@implementation UIView (Border)

//borderItems
-(NSArray<NSBorderItem *> *)borderItems {
    return self.borderView.borderItems;
}
- (void)setBorderItems:(NSArray<NSBorderItem *> *)borderItems {
    self.borderView.borderItems = borderItems;
}

//borderView
- (void)setBorderView:(UIMBorderView *)borderView {
    objc_setAssociatedObject(self, key_UIView_BorderView, borderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIMBorderView *)borderView {
    UIMBorderView *borderView = objc_getAssociatedObject(self, key_UIView_BorderView);
    if (!borderView) {
        self.borderView = [[UIMBorderView alloc] initWithFrame:self.bounds];
        self.borderView.backgroundColor = [UIColor clearColor];
        self.borderView.translatesAutoresizingMaskIntoConstraints = NO;
        self.borderView.userInteractionEnabled = NO;
        borderView = objc_getAssociatedObject(self, key_UIView_BorderView);
        [self addSubview:borderView];
    }
    return borderView;
}

//borderWidth
- (CGFloat)borderWidth {
    return self.borderView.borderWidth;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.borderView.mBorderWidth = borderWidth;
}

//boderColor
- (UIColor *)borderColor {
    return self.borderView.mColorBorder;
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.borderView.mColorBorder = borderColor;
}

//borderType
- (UIViewBorderType)borderType {
    return [objc_getAssociatedObject(self, key_UIView_BorderType) integerValue];
}
- (void)setBorderType:(UIViewBorderType)borderType {
    objc_setAssociatedObject(self,
                             key_UIView_BorderType,
                             @(borderType),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.borderEdge = self.borderEdge;
    self.borderView.mBordertype = borderType;
}

//borderEdge
- (UIEdgeInsets)borderEdge {
    return [objc_getAssociatedObject(self, key_UIView_BorderEdge) UIEdgeInsetsValue];
}
- (void)setBorderEdge:(UIEdgeInsets)borderEdge {
    objc_setAssociatedObject(self,
                             key_UIView_BorderEdge,
                             [NSValue valueWithUIEdgeInsets:borderEdge],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIView *_borderView = self.borderView;
    
    for (NSLayoutConstraint *contast in self.constraints) {
        if (contast.firstItem == _borderView && contast.secondItem == self) {
            [self removeConstraint:contast];
        }
        if (contast.firstItem == self && contast.secondItem == _borderView) {
            [self removeConstraint:contast];
        }
    }
    NSDictionary *dict = @{@"left":@(borderEdge.left),
                           @"right":@(borderEdge.right),
                           @"bottom":@(borderEdge.bottom),
                           @"top":@(borderEdge.top)};
    
    NSArray *_contratintHs = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==left)-[_borderView]-(==right)-|"
                                                                     options:0
                                                                     metrics:dict
                                                                       views:NSDictionaryOfVariableBindings(_borderView)];
    [self addConstraints:_contratintHs];
    
    NSArray *_contratintVs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==top)-[_borderView]-(==bottom)-|"
                                                                     options:0
                                                                     metrics:dict
                                                                       views:NSDictionaryOfVariableBindings(_borderView)];
    [self addConstraints:_contratintVs];
}


- (void)bringBorderViewToFront {
    [self bringSubviewToFront:self.borderView];
}
- (void)sendBorderViewToBack {
    [self sendSubviewToBack:self.borderView];
}

@end
