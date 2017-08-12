//
//  UIScrollView+PageNumber.h
//  Category
//
//  Created by 杨晴贺 on 04/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (PageNumber)

-(NSInteger)totalPages;

-(void)setPageNumber:(NSInteger)pageNumber animated:(BOOL)animated;
-(void)setPageNumber:(NSInteger)pageNumber;
-(NSInteger)pageNumber;

-(BOOL)isLastPage;
-(BOOL)isFirstPage;

@end
