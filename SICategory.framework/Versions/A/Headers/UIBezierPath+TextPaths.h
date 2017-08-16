//
//  UIBezierPath+TextPaths.h
//  Category
//
//  Created by Silence on 2017/5/29.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (TextPaths)

/** @name Path from NSString */

/**
 Create a bezier path for a specified string rendered with a specified font.
 @param string The string to produce the path for. Must not be `nil`.
 @param font   The font to use for producing the string glyphs. Must not be `nil`.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string.
 @discussion If either the string or font paramter are set to `nil` then the method will return `nil`. If the string contains any newline characters they will be ingored and the string will be rendered on a single line.
 */
+ (UIBezierPath *)pathForString:(NSString *)string
                       withFont:(UIFont *)font;

/**
 Create a bezier path for a specified string that consumes multiple lines rendered with a specified font.
 @param string    The string to produce the path for. Must not be `nil`.
 @param font      The font to use for producing the string glyphs. Must not be `nil`.
 @param maxWidth  The maximum width of a line, if a line when rendered is longer than this width then the line is broken to a new line. Must be greater than 0.
 @param alignment The alignment of text. This method supports Left, Center, Right & Justified alignment; Natural will be treated as Left.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string.
 */
+ (UIBezierPath *)pathForMultilineString:(NSString *)string
                                withFont:(UIFont *)font
                                maxWidth:(CGFloat)maxWidth
                           textAlignment:(NSTextAlignment)alignment;



/** @name Path from NSAttributedString */

/**
 Create a bezier path for a specified attributed string.
 @param string The string to produce the path for. Must not be `nil`.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string. If the input string is `nil` then `nil` is returned.
 @discussion If the string contains any newline characters they will be ingored and the string will be rendered on a single line.
 */
+ (UIBezierPath *)pathForAttributedString:(NSAttributedString *)string;


/**
 Create a bezier path for a specified attributed string that consumes multiple lines.
 @param string   The string to produce the path for. Must not be `nil`.
 @param maxWidth The maximum width of a line, if a line when rendered is longer than this width then the line is broken to a new line. Must be greater than 0.
 @return A `UIBezierPath` that contains a path with paths for all the glyphs for specifed string.
 */
+ (UIBezierPath *)pathForMultilineAttributedString:(NSAttributedString *)string
                                          maxWidth:(CGFloat)maxWidth;

@end
