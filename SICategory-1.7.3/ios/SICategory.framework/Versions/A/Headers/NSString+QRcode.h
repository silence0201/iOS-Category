//
//  NSString+QRcode.h
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@interface NSString (QRcode)

/**
 String的二维码信息

 @return String的二维码图片
 */
- (UIImage *)QRcode ;

@end
