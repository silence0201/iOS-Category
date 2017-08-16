//
//  UIButton+Block.m
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static const void *UIButtonBlockKey = &UIButtonBlockKey;
@implementation UIButton (Block)

-(void)addActionHandler:(TouchedBlock)touchHandler{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionTouched:(UIButton *)btn{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn);
    }
}

@end
