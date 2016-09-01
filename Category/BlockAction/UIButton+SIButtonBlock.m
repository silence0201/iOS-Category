//
//  UIButton+SIButtonBlock.m
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIButton+SIButtonBlock.h"

// 内部类
@interface MyButton : UIButton

@property (nonatomic,copy) ButtonActionBlock actionBlock ;

@end

@implementation MyButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside] ;
    }
    return self ;
}


- (void)buttonClick:(UIButton *)button{
    if (self.actionBlock) {
        self.actionBlock(self) ;
    }
}

@end

@implementation UIButton (SIButtonBlock)

+ (instancetype)SI_buttonCustomButtonFrame:(CGRect)frame
                                     title:(NSString *)title
                         currentTitleColor:(UIColor *)color
                               actionBlock:(ButtonActionBlock)block{
    MyButton *button = [MyButton buttonWithType:UIButtonTypeCustom] ;
    button.frame = frame ;
    [button setTitle:title forState:UIControlStateNormal] ;
    [button setTitleColor:color forState:UIControlStateNormal] ;
    button.actionBlock = block ;
    return button ;
}

+ (instancetype)SI_buttonCustomButtonFrame:(CGRect)frame
                           normalImageName:(NSString *)imageName
                               actionBlock:(ButtonActionBlock)block{
    MyButton *button = [MyButton buttonWithType:UIButtonTypeCustom] ;
    button.frame = frame ;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal] ;
    button.actionBlock = block ;
    return button ;
}

@end
