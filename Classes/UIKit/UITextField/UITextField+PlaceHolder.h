//
//  UITextField+PlaceHolder.h
//  Category
//
//  Created by 杨晴贺 on 2017/3/21.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (PlaceHolder)<UITextViewDelegate>
@property (nonatomic, strong) UITextView *placeHolderTextView;
- (void)addPlaceHolder:(NSString *)placeHolder;
@end
