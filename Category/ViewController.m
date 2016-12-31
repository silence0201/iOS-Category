//
//  ViewController.m
//  Category
//
//  Created by 杨晴贺 on 29/12/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "NSKeyedArchiver+Key.h"
#import "NSString+Path.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@"1",@"2",@"3"] ;
    NSString *path = [NSString filePathAtDocumentsWithFileName:@"baid"] ;
    [NSKeyedArchiver archiveRootObject:array forKey:@"kk" WithFolderPath:path] ;
    [NSKeyedArchiver removeArchiveForKey:@"kk"] ;
}


@end
