//
//  UIViewController+Segues.h
//  Category
//
//  Created by Silence on 2017/3/22.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewControllerSeguesPrepareCallback)(UIViewController* target);

@interface UIViewController (Segues)

- (void)performSegueWithIdentifier:(NSString *)identifier prepareCallback:(UIViewControllerSeguesPrepareCallback)callback;

@end
