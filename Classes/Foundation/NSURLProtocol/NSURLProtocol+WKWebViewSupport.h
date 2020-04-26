//
//  NSURLProtocol+WKWebViewSupport.h
//  Category
//
//  Created by Silence on 2020/4/26.
//  Copyright © 2020年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURLProtocol (WKWebViewSupport)

+ (void)wk_registerScheme:(NSString *)scheme;
+ (void)wk_unregisterScheme:(NSString *)scheme;

@end

NS_ASSUME_NONNULL_END
