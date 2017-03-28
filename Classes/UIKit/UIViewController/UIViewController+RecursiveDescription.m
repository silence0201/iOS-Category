//
//  UIViewController+RecursiveDescription.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIViewController+RecursiveDescription.h"

@implementation UIViewController (RecursiveDescription)

-(NSString*)recursiveDescription{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self addDescriptionToString:description indentLevel:0];
    return description;
}

-(void)addDescriptionToString:(NSMutableString*)string indentLevel:(NSInteger)indentLevel{
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@",[self debugDescription],NSStringFromCGRect(self.view.frame)];
    
    for (UIViewController *childController in self.childViewControllers)
    {
        [string appendFormat:@"\n%@>",padding];
        [childController addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}

@end
