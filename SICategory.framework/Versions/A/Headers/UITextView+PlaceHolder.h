//
//  UITextView+PlaceHolder.h
//  Category
//
//  Created by Silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (PlaceHolder)<UITextViewDelegate>

@property (nonatomic, strong) UITextView *placeHolderTextView;
- (void)addPlaceHolder:(NSString *)placeHolder;

@end
