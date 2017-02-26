# iOS-Category

![Language](https://img.shields.io/badge/language-objc-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
[![CocoaPods](http://img.shields.io/cocoapods/v/YYKit.svg?style=flat)](http://cocoapods.org/?q=SICategory) 
[![CocoaPods](http://img.shields.io/cocoapods/p/YYKit.svg?style=flat)](http://cocoapods.org/?q= SICategory)

功能强大的iOS开发分类

主要包括一下内容:
#### [Foundation](Classes/Foundation)
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

#### [UIKit](Classes/UIKit)
* [UIApplication](Classes/UIKit/UIApplication):App相关信息获取,权限判断,键盘Frame
* [UITabBarController](Classes/UIKit/UITabBarController):UITabBar隐藏
* [UIBarButtonItem](Classes/UIKit/UIBarButtonItem):Block封装操作
* [UIButton](Classes/UIKit/UIButton):设置背景,Block封装操作,点击相应范围处理,倒计时快速实现, Indicator快速添加
* [UIColor](Classes/UIKit/UIColor):增添更多颜色,颜色操作
* [UIControl](Classes/UIKit/UIControl):Block封装,设置延时相应
* [UIDevice](Classes/UIKit/UIDevice):CPU信息获取,存储信息获取,网络信息获取,设备信息获取
* [UIFont](Classes/UIKit/UIFont):加载字体方法封装,字体快速创建,字体特征获取
* [UIGestureRecognizer](Classes/UIKit/UIGestureRecognizer):手势Block封装
* [UIImage](Classes/UIKit/UIImage):截屏,用颜色构造方法,压缩,加效果,Fix,Gif,导出,合并,修改,旋转
* [UILabel](Classes/UIKit/UILabel):获取内容Size,设置间距
* [UINavigationController](Classes/UIKit/UINavigationController):Stack管理, Transitions添加
* [UIScreen](Classes/UIKit/UIScreen):屏幕信息获取
* [UIScrollView](Classes/UIKit/UIScrollView):下拉放大效果,PageNumber快速获取,滚动实现
* [UITableView](Classes/UIKit/UITableView):设置Cell样式,修改数据源
* [UIView](Classes/UIKit/UIView):快速添加动画,Block封装,灵活的添加border,快速获取约束信息,快速寻找,Frame便捷操作,圆角设置,截屏, Toast
* [UIViewController](Classes/UIKit/UIViewController):快速Alert,PopView, TopWarningView
* [UINavigationBar](Classes/UIKit/UINavigationBar):快速设置简单的外观

### [EXTObj](Classes/EXTObj)
libextobjc currently includes the following features:

 * **Safe categories**, using EXTSafeCategory, for adding methods to a class without overwriting anything already there (identifying conflicts for you).
 * **Concrete protocols**, using EXTConcreteProtocol, for providing default implementations of the methods in a protocol.
 * **Simpler and safer key paths**, using EXTKeyPathCoding, which automatically checks key paths at compile-time.
 * **Compile-time checking of selectors** to ensure that an object declares a given selector, using EXTSelectorChecking.
 * **Easier use of weak variables in blocks**, using `@weakify`, `@unsafeify`, and `@strongify` from the EXTScope module.
 * **Scope-based resource cleanup**, using `@onExit` in the EXTScope module, for automatically cleaning up manually-allocated memory, file handles, locks, etc., at the end of a scope.
 * **Algebraic data types** generated completely at compile-time, defined using EXTADT.
 * **Synthesized properties for categories**, using EXTSynthesize.
 * **Block-based coroutines**, using EXTCoroutine.
 * **EXTNil, which is like `NSNull`, but behaves much more closely to actual `nil`** (i.e., doesn't crash when sent unrecognized messages).
 * **Lots of extensions** and additional functionality built on top of `<objc/runtime.h>`, including extremely customizable method injection, reflection upon object properties, and various functions to extend class hierarchy checks and method lookups.

 ### [Manager](Classes/Manager)
 * [SIKeyboardShortcutManager](Classes/Manager/SIKeyboardShortcutManager.h):虚拟机快捷键管理
 * [SIAuthorizationManager](Classes/Manager/SIAuthorizationManager.h):认证管理
 * [SITouchIDManager](Classes/Manager/SITouchIDManager.h):TouchID管理
 * [SIBluetoothManager](Classes/Manager/SIBluetoothManager.h):蓝牙信息管理
 * [SIMediatorManager](Classes/Manager/SIMediatorManager.h):中间层管理
 * [SIKeyboardManager](Classes/Manager/SIKeyboardManager.h):键盘管理
 * [SIIAppPurchaseManager](Classes/Manager/SIIAppPurchaseManager.h):内购管理
 * [SIAppVersionManager](Classes/Manager/SIAppVersionManager.h):版本管理
 * [SIDownloadManager](Classes/Manager/SIDownloadManager.h):下载管理

### [Macros](Classes/Macros)
* [SIWarningMacro](Classes/Macros/SIWarningMacro.h) : 忽略⚠️
* [SIViewMacro](Classes/Macros/SIViewMacro.h):ViewMacro
* [SIUtilsMacro](Classes/Macros/SIUtilsMacro.h): UtilsMacro
* [SIShortcutsMacro](Classes/Macros/SIShortcutsMacro.h):ShortcutsMacro
* [SISharedInstanceMacro](Classes/Macros/SISharedInstanceMacro.h):SharedInstanceMacro
* [SIMathMacro](Classes/Macros/SIMathMacro.h):SIMathMacro
* [SILogMacro](Classes/Macros/SILogMacro.h):LogMacro
* [SIFRCMacro](Classes/Macros/SIFRCMacro.h):FRCMacro
* [SIDeviceMacro](Classes/Macros/SIDeviceMacro.h):DeviceMacro
* [SICoreGraphicsMacro](Classes/Macros/SICoreGraphicsMacro.h):CoreGraphicsMacro
* [SIARCMacro](Classes/Macros/SIARCMacro.h):ARCMacro
* [SIRuntimeMacro](Classes/Macros/SIRuntimeMacro):RuntimeMacro
* [SIColorMacro](Classes/Macros/SIColorMacro.h):ColorMacro
* [SICollectionMacro](Classes/Macros/SICollectionMacro):CollectionMacro
* [SIGCDMacro](Classes/Macros/SIGCDMacro.h):GCDMacro
* [SINotificationMacro](Classes/Macros/SINotificationMacro.h):NotificationMacro
* [SIExceptionMacro](Classes/Macros/SIExceptionMacro.h):ExceptionMacro
* [SIAutoLayoutMacro](Classes/Macros/SIAutoLayoutMacro.h):AutoLayoutMacro

##使用说明

####手工导入
所有的分类独立,可以按照需求进行导入 
如果想要全部导入只需要将`Classes`中文件拉入项目中即可

####Pod导入
使用全部功能

	pod 'SICategory', '~> 1.0'
	
只使用`UIKit`相关分类
	
	pod 'SICategory/SIUIKit', '~> 1.0'
	
只使用`Foundation`相关分类

	pod 'SICategory/SIFoundation', '~> 1.0'
	
只使用`EXTObj `

	pod 'SICategory/EXTObj', '~> 1.0'
	
只使用`Manager `

	pod 'SICategory/Manager', '~> 1.0'
	
只使用`SIMacros `

	pod 'SICategory/SIMacros', '~> 1.0'


	

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
