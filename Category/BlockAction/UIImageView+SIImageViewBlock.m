//
//  UIImageView+SIImageViewBlock.m
//  Category
//
//  Created by 杨晴贺 on 9/1/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "UIImageView+SIImageViewBlock.h"

@interface MyImageView : UIImageView

@property (nonatomic,copy) ImageViewActionBlock clickBlock ;

@end

@implementation MyImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES ;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)] ;
        [self addGestureRecognizer:singleTap] ;
    }
    return self ;
}

- (void)clickImageView:(UIImageView *)view{
    if(_clickBlock){
        _clickBlock(view) ;
    }
}

@end

@implementation UIImageView (SIImageViewBlock)

+ (instancetype)SI_imageViewWithFrame:(CGRect)frame
                            imageName:(NSString *)name
                          clickAction:(ImageViewActionBlock)block{
    MyImageView *imageView = [[MyImageView alloc]initWithFrame:frame] ;
    imageView.image = [UIImage imageNamed:name] ;
    imageView.clickBlock = block ;
    return imageView ;
    
}

@end
