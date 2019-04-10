//
//  NSString+AttributedBuilder.h
//  Category
//
//  Created by Silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//


#import <UIKit/UIKit.h>

@class SIAttributedStringBuilder;
@interface NSString (AttributedBuilder)

- (SIAttributedStringBuilder *)builder ;

@end

/**-----------------------------辅助类-------------------------------**/
/// 区间
@interface SIAttributedStringRange : NSObject

/// 字体
-(SIAttributedStringRange *)setFont:(UIFont *)font;
/// 文字颜色
-(SIAttributedStringRange *)setTextColor:(UIColor *)color;
/// 背景色
-(SIAttributedStringRange *)setBackgroundColor:(UIColor *)color;
/// 段落样式
-(SIAttributedStringRange *)setParagraphStyle:(NSParagraphStyle *)paragraphStyle;
/// 连体字符
-(SIAttributedStringRange *)setLigature:(BOOL)ligature;
/// 字间距
-(SIAttributedStringRange *)setKern:(CGFloat)kern;
/// 行间距
-(SIAttributedStringRange *)setLineSpacing:(CGFloat)lineSpacing;
/// 删除线
-(SIAttributedStringRange *)setStrikethroughStyle:(int)strikethroughStyle;
/// 删除线颜色
-(SIAttributedStringRange *)setStrikethroughColor:(UIColor *)StrikethroughColor NS_AVAILABLE_IOS(7_0);
/// 下划线
-(SIAttributedStringRange *)setUnderlineStyle:(NSUnderlineStyle)underlineStyle;
/// 下划线颜色
-(SIAttributedStringRange *)setUnderlineColor:(UIColor *)underlineColor NS_AVAILABLE_IOS(7_0);
/// 阴影
-(SIAttributedStringRange *)setShadow:(NSShadow *)shadow;
-(SIAttributedStringRange *)setTextEffect:(NSString *)textEffect NS_AVAILABLE_IOS(7_0);
/// 将区域中的特殊字符: NSAttachmentCharacter,替换为attachement中指定的图片,这个来实现图片混排
-(SIAttributedStringRange *)setAttachment:(NSTextAttachment *)attachment NS_AVAILABLE_IOS(7_0);
/// 设置区域内的文字点击后打开的链接
- (SIAttributedStringRange *)setLink:(NSURL *)url NS_AVAILABLE_IOS(7_0);
/// 设置基线的偏移量，正值为往上，负值为往下，可以用于控制UILabel的居顶或者居低显示
-(SIAttributedStringRange *)setBaselineOffset:(CGFloat)baselineOffset NS_AVAILABLE_IOS(7_0);
/// 设置倾斜度
-(SIAttributedStringRange *)setObliqueness:(CGFloat)obliqueness NS_AVAILABLE_IOS(7_0);
/// 压缩文字，正值为伸，负值为缩
-(SIAttributedStringRange *)setExpansion:(CGFloat)expansion NS_AVAILABLE_IOS(7_0);
/// 中空文字的颜色
-(SIAttributedStringRange *)setStrokeColor:(UIColor *)strokeColor;
/// 中空的线宽度
-(SIAttributedStringRange *)setStrokeWidth:(CGFloat)strokeWidth;

///设置多个属性
-(SIAttributedStringRange *)setAttributes:(NSDictionary *)dict;

@end

/// 构造器
@interface SIAttributedStringBuilder : NSObject

+(SIAttributedStringBuilder *)builderWith:(NSString *)string;
-(id)initWithString:(NSString *)string;

/// 指定区域,如果没有属性串或者字符串为nil则返回nil
-(SIAttributedStringRange *)range:(NSRange)range;
/// 全部字符
-(SIAttributedStringRange *)allRange;
/// 最后一个字符
-(SIAttributedStringRange *)lastRange;
/// 最后N个字符
-(SIAttributedStringRange *)lastNRange:(NSInteger)length;
/// 第一个字符
-(SIAttributedStringRange *)firstRange;
/// 前面N个字符
-(SIAttributedStringRange *)firstNRange:(NSInteger)length;
/// 用于选择特殊的字符
-(SIAttributedStringRange *)characterSet:(NSCharacterSet*)characterSet;
/// 用于选择特殊的字符串
-(SIAttributedStringRange *)includeString:(NSString*)includeString all:(BOOL)all;
/// 正则表达式
-(SIAttributedStringRange *)regularExpression:(NSString*)regularExpression all:(BOOL)all;


//段落处理,以\n结尾为一段，如果没有段落则返回nil
/// 第一段
-(SIAttributedStringRange *)firstParagraph;
/// 最后一段
-(SIAttributedStringRange *)nextParagraph;

/// 插入，如果为0则是头部，如果为-1则是尾部
-(void)insert:(NSInteger)pos attrstring:(NSAttributedString *)attrstring;
/// 插入，如果为0则是头部，如果为-1则是尾部
-(void)insert:(NSInteger)pos attrBuilder:(SIAttributedStringBuilder *)attrBuilder;

/// 构造好的attributedString
-(NSAttributedString *)commit;

@end
