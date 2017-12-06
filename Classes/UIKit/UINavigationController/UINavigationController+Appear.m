//
//  UINavigationController+Appear.m
//  Category
//
//  Created by Silence on 2017/12/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UINavigationController+Appear.h"

@implementation UINavigationController (Appear)

- (void)setBarBackgroundColor:(UIColor *)color {
    UIImage *backgroundImage = [self _imageWithColor:color size:CGSizeMake(1, 1)];
    [self.navigationBar setBackgroundImage:backgroundImage
                             forBarMetrics:UIBarMetricsDefault];
}

- (void)setInteractivePopGestureRecognizerEnable:(BOOL)enable {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = enable;
    }
}

- (void)setTitleColor:(UIColor *)color font:(UIFont *)font {
    NSDictionary *textAttributes;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    textAttributes = @{
                       UITextAttributeFont: font,
                       UITextAttributeTextColor: color,
                       UITextAttributeTextShadowColor: [UIColor clearColor],
                       UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                       };
#else
    textAttributes = @{
                       NSFontAttributeName: font,
                       NSForegroundColorAttributeName: color,
                       };
#endif
    
    [self.navigationBar setTitleTextAttributes:textAttributes];
}

- (void)setBarBackgroundImage:(NSString *)imageName {
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:imageName]
                             forBarMetrics:UIBarMetricsDefault];
}

- (void)setBarTitle:(NSString *)title {
    self.visibleViewController.navigationItem.title = title;
}

- (void)setBarTitleView:(UIView *)view {
    [self.visibleViewController.navigationItem setTitleView:view];
}

- (UIButton *)addItemWithTitle:(NSString *)title iconImage:(NSString *)iconImageName backgroundImage:(NSString *)backgroundImageName target:(id)target action:(SEL)action orientation:(SIBarItemOrientation)orientation {
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font=[UIFont systemFontOfSize:17.0];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    button.backgroundColor=[UIColor clearColor];
    
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    if (iconImageName) {
        [button setImage:[UIImage imageNamed:iconImageName] forState:UIControlStateNormal];
    }
    
    if (backgroundImageName) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    }
    
    [button sizeToFit];
    button.frame=CGRectMake(0,0,CGRectGetWidth(button.frame)+20,34);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    if (orientation == SIBarItemOrientationLeft) {
        NSMutableArray *arrayItems = [NSMutableArray arrayWithArray:self.visibleViewController.navigationItem.leftBarButtonItems];
        if (arrayItems.count > 0) {
            [arrayItems addObject:item];
            self.visibleViewController.navigationItem.leftBarButtonItems = arrayItems;
        } else {
            [self addLeftBarButtonItem:item];
        }
    } else {
        NSMutableArray *arrayItems = [NSMutableArray arrayWithArray:self.visibleViewController.navigationItem.rightBarButtonItems];
        if (arrayItems.count > 0) {
            [arrayItems addObject:item];
            self.visibleViewController.navigationItem.rightBarButtonItems = arrayItems;
        } else {
            [self addRightBarButtonItem:item];
        }
    }
    
    return button;
}

- (void)clearAllItem {
    self.visibleViewController.navigationItem.leftBarButtonItems = nil;
    self.visibleViewController.navigationItem.rightBarButtonItems = nil;
}

-(void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem{
    self.visibleViewController.navigationItem.leftBarButtonItems = [self createBarButtonItems:@[leftBarButtonItem]];
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    self.visibleViewController.navigationItem.rightBarButtonItems = [self createBarButtonItems:@[rightBarButtonItem]];
}

#pragma mark --- Private
- (NSArray *)createBarButtonItems:(NSArray *)barButtonItems {
    NSMutableArray *buttonItemArray=[[NSMutableArray alloc]init];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0 ){
        negativeSpacer.width = -15;
        [buttonItemArray addObject:negativeSpacer];
        [buttonItemArray addObjectsFromArray:barButtonItems];
    } else{
        negativeSpacer.width = 0;
        [buttonItemArray addObjectsFromArray:barButtonItems];
    }
    
    return buttonItemArray;
}

- (UIImage *)_imageWithColor:(UIColor*)color size:(CGSize)size{
    CGRect imgRect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(imgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imgRect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
