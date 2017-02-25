//
//  SIARCMacros.h
//  Category
//
//  Created by 杨晴贺 on 16/02/2017.
//  Copyright © 2017 silence. All rights reserved.
//

// 强弱引用
#define WeakSelf          __weak __typeof(self) weakSelf = self;
#define StrongSelf        __strong __typeof(weakSelf)strongSelf = weakSelf;
