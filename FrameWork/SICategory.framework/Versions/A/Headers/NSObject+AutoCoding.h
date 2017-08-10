//
//  NSObject+AutoCoding.h
//  Category
//
//  Created by 杨晴贺 on 2017/5/10.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AutoCoding) <NSSecureCoding>

/**
 *  返回包含所有属性的名称和类的字典
 *  该类将被自动保存，加载和复制时的对象
 *  使用`NSKeyedArchiver / Unarchiver'存档
 *  表示用于对每个属性进行编码的类（例如`NSString`用于字符串，
 *  `NSNumber`用于数值或布尔值，`NSValue`用于结构体等）。
 *
 *  通过扫描定义的属性自动生成此字典
 *  在运行时的类定义。 只读和私有属性也将显示
 *  只要具有符合KVC的ivar名称（即ivar匹配）即可编码属性
 *  不支持ivar，或者ivar名称与属性名称不符不会被编码
 *
 *  除非您想添加，通常不需要重写此方法
 *  用于没有匹配属性定义的编码的ivars，或者如果希望编写虚拟属性（属性或setter / getter方法对没有ivar支持）
 *  如果你想排除某些属性序列化过程中，您可以故意给他们一个不符合KVC的
 *
 *  请注意，此方法仅返回特定值上定义的属性
 *  您如果您重写此方法，则不需要调用`[super codableProperties]`。
 */
+ (NSDictionary<NSString *, Class> *)codableProperties;

/**
 * 使用提供的基于NSCoder对象填充对象的属性
 * 在`codableProperties`字典。 这是由内部调用的
 * `initWithCoder：`方法，但如果要初始化一个对象可能很有用
 * 编码档案已经被创建完毕。 你甚至可以通过合并几个不同档案的结果来初始化对象
 * 多次调用`setWithCoder：`。
 */
- (void)setWithCoder:(NSCoder *)aDecoder;

/**
 * 返回对象的所有可编码属性，包括那些继承自超类。 你不应该重写这个方法
 * 如果你想添加其他属性，覆盖`+ codableProperties`类方法代替。
 */
@property (nonatomic, readonly) NSDictionary<NSString *, Class> *codableProperties;

/**
 * 返回所有可编码属性的值的字典对象。 它相当于使用`dictionaryWithValuesForKeys：`
 * 以“object.codableProperties.allKeys”为参数的结果。
 */
@property (nonatomic, readonly) NSDictionary<NSString *, id> *dictionaryRepresentation;

/**
 *  尝试使用以下顺序加载文件：
 *  1）如果文件是NSCoded存档，加载根对象并返回; 
 *  2）如果文件是普通Plist，加载并返回根对象; 
 *  3）返回原始数据`NSData`对象。 如果解除序列化的对象不是类的子类被用来加载它，会抛出异常（为避免这种情况，调用方法在`NSObject`而不是一个特定的子类）。
 */
+ (instancetype)objectWithContentsOfFile:(NSString *)path;

/**
 * 尝试将文件写入磁盘。 该方法被覆盖“NSData”，“NSDictionary”和“NSArray”等效的方法
 * 它保存文件作为可读的XML Plist而不是二进制NSCoded Plist存档，
 * 但是'objectWithContentsOfFile：`方法将会正确地对这些进行顺序排列
 * 再次反过来 对于任何其他对象，它将使用该序列化对象
 * `NSCoding`协议，并将文件写成NSCoded二进制Plist存档。
 * 成功返回“YES”，失败时返回“否”。
 */
- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)useAuxiliaryFile;

@end

NS_ASSUME_NONNULL_END

