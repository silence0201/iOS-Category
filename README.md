# iOS-Category
功能强大的iOS开发分类

主要包括一下内容:
####Foundation
* [NSArchiver](Classes/Foundation/NSArchiver):利用key实现快速归档和解档
* [NSArray](Classes/Foundation/NSArray):数组的Block操作,JSON解析,Plist解析,安全访问
* [NSBundle](Classes/Foundation/NSBundle):快速获取与App相关的信息
* [NSData](Classes/Foundation/NSData):数据缓存,编码和界面,Hash加密,加密和解密
* [NSDate](Classes/Foundation/NSDate):日期快速访问,日期的相关计算,日期格式化
* [NSDictionary](Classes/Foundation/NSDictionary):字典Block操作,JSON解析,Plist解析,安全访问,URL处理,字典合并
* [NSFileManager](Classes/Foundation/NSFileManager):与文件相关操作的方法封装
* [NSLog](Classes/Foundation/NSLog):增强的日志功能
* [NSNotificationCenter](Classes/Foundation/NSNotificationCenter):自动移除监听,线程操作
* [NSNumber](Classes/Foundation/NSNumber):数字显示格式化,罗马数字转换,小数处理
* [NSObject](Classes/Foundation/NSObject):AOP处理,Block,GCD封装,简单模型转换,快速增加关联,快速序列化,快速copy,反射以及Runtime方法封装
* [NSString](Classes/Foundation/NSString):APP信息获取,判断是否存在,Emoji判断,Hash处理,JSON编码,MIME,路径快速获取,PinYin处理,快速生成二维码,检查是否符合,字符串Size,URLCode格式化
* [NSTimer](Classes/Foundation/NSTimer):Block方法封装
* [NSURL](Classes/Foundation/NSURL):URL查询转化

####UIKit
* [UIApplication](Classes/UIKit/UIApplication)
* [UIBarButtonItem](Classes/UIKit/UIBarButtonItem)
* [UIButton](Classes/UIKit/UIButton)
* [UIColor](Classes/UIKit/UIColor)
* [UIControl](Classes/UIKit/UIControl)
* [UIDevice](Classes/UIKit/UIDevice)
* [UIFont](Classes/UIKit/UIFont)
* [UIGestureRecognizer](Classes/UIKit/UIGestureRecognizer)
* [UIImage](Classes/UIKit/UIImage)
* [UILabel](Classes/UIKit/UILabel)
* [UINavigationController](Classes/UIKit/UINavigationController)
* [UIScreen](Classes/UIKit/UIScreen)
* [UIScrollView](Classes/UIKit/UIScrollView)
* [UITableView](Classes/UIKit/UITableView)
* [UIView](Classes/UIKit/UIView)
* [UIViewController](Classes/UIKit/UIViewController)
* [UINavigationBar](Classes/UIKit/UINavigationBar)

##使用说明

####手工导入
所有的分类独立,可以按照需求进行导入 
如果想要全部导入只需要将`Classes`中文件拉入项目中即可

####Pod导入
使用全部功能

	pod 'SICategory', '~> 1.0'
	
只是用`UIKit`相关分类
	
	pod 'SICategory/SIUIKit', '~> 1.0'
	
只是用`Foundation`相关分类

	pod 'SICategory/SIFoundation', '~> 1.0'
	

###使用
导入头文件:

使用全部:
	
	#import "SICategory.h" 
	
使用`Foundation`部分:

	#import "SIFoundation.h"
	
使用`UIKit`部分

	#import "SIUIKit.h"
	
##iOS-Category
iOS-Category is available under the MIT license. See the LICENSE file for more info.
