//
//  SIMaths.h
//  Category
//
//  Created by Silence on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// 度弧度转换
#define DEGREES_TO_RADIANS(degrees) ((degrees*M_PI)/180.0)
#define RADIANS_TO_DEGREES(radians) ((radians*180.0)/M_PI)

// 随机Int
#define RANDOM_INT(from,to)             ((int)((from) + arc4random() % ((to)-(from) + 1)))

