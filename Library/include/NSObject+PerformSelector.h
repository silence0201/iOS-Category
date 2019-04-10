//
//  NSObject+PerformSelector.h
//  Category
//
//  Created by Silence on 2017/8/23.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

@end
