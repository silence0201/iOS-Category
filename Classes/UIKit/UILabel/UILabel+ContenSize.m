//
//  UILabel+ContenSize.m
//  Category
//
//  Created by Silence on 02/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UILabel+ContenSize.h"

@implementation UILabel (ContenSize)

- (CGSize)contentSizeForWidth:(CGFloat)width{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    CGRect contentFrame = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : self.font } context:nil];
    return contentFrame.size;
}

- (CGSize)contentSize{
    return [self contentSizeForWidth:CGRectGetWidth(self.bounds)];
}

- (BOOL)isTruncated{
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    return (size.height > self.frame.size.height);
}

@end
