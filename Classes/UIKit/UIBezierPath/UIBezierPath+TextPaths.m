//
//  UIBezierPath+TextPaths.m
//  Category
//
//  Created by Silence on 2017/5/29.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIBezierPath+TextPaths.h"
#import <CoreText/CoreText.h>

CGPathRef CGPathCreateSingleLineStringWithAttributedString(NSAttributedString *attrString)
{
    CGMutablePathRef letters = CGPathCreateMutable();
    
    
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
    }
    
    CFRelease(line);
    
    CGPathRef finalPath = CGPathCreateCopy(letters);
    CGPathRelease(letters);
    return finalPath;
}


#pragma mark - Multiple Line String Path

CGPathRef CGPathCreateMultilineStringWithAttributedString(NSAttributedString *attrString, CGFloat maxWidth, CGFloat maxHeight)
{
    CGMutablePathRef letters = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0, 0, maxWidth, maxHeight);
    CGPathRef pathRef = CGPathCreateWithRect(bounds, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attrString));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef, NULL);
    CFArrayRef lines = CTFrameGetLines(frame);
    CGPoint *points = malloc(sizeof(CGPoint) * CFArrayGetCount(lines));
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    NSInteger numLines = CFArrayGetCount(lines);
    for (CFIndex lineIndex = 0; lineIndex < numLines; lineIndex++)
    {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, lineIndex);
        
        CFRange r = CTLineGetStringRange(lineRef);
        
        NSParagraphStyle *paragraphStyle = [attrString attribute:NSParagraphStyleAttributeName atIndex:r.location effectiveRange:NULL];
        NSTextAlignment alignment = paragraphStyle.alignment;
        
        
        CGFloat flushFactor = 0.0;
        if (alignment == NSTextAlignmentLeft) {
            flushFactor = 0.0;
        } else if (alignment == NSTextAlignmentCenter) {
            flushFactor = 0.5;
        } else if (alignment == NSTextAlignmentRight) {
            flushFactor = 1.0;
        }
        CGFloat penOffset = CTLineGetPenOffsetForFlush(lineRef, flushFactor, maxWidth);
        if (alignment == NSTextAlignmentJustified) {
            lineRef = CTLineCreateJustifiedLine(lineRef, 1.0, maxWidth);
            penOffset = 0;
        }
        
        CGFloat lineOffset = numLines == 1 ? 0 : maxHeight - points[lineIndex].y;
        CFArrayRef runArray = CTLineGetGlyphRuns(lineRef);
        for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
        {
            CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
            CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
            for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
            {
                CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                CGGlyph glyph;
                CGPoint position;
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                
                position.y -= lineOffset;
                position.x += penOffset;
                
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(letters, &t, letter);
                CGPathRelease(letter);
            }
        }
        if (alignment == NSTextAlignmentJustified) {
            CFRelease(lineRef);
        }
    }
    
    free(points);
    
    CGPathRelease(pathRef);
    CFRelease(frame);
    CFRelease(framesetter);
    
    CGRect pathBounds = CGPathGetBoundingBox(letters);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-pathBounds.origin.x, -pathBounds.origin.y);
    CGPathRef finalPath = CGPathCreateCopyByTransformingPath(letters, &transform);
    CGPathRelease(letters);
    
    return finalPath;
}
// for the multiline the CTFrame must have a max path size. This value is arbitrary, currently 4x the height of ipad screen.
#define MAX_HEIGHT_OF_FRAME 4096
@implementation UIBezierPath (TextPaths)

#pragma mark - NSString


+ (UIBezierPath *)pathForString:(NSString *)string withFont:(UIFont *)font
{
    // if there is no string or font then just return nil.
    if (!string || !font) return nil;
    
    // create the dictionary of attributes for the attributed string contaning the font.
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    
    // create the attributed string.
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    // create path from attributed string.
    return [self pathForAttributedString:attrString];
}


+ (UIBezierPath *)pathForMultilineString:(NSString *)string
                                withFont:(UIFont *)font
                                maxWidth:(CGFloat)maxWidth
                           textAlignment:(NSTextAlignment)alignment

{
    // if there is no string or font or no width then just return nil.
    if (!string || !font || maxWidth <= 0.0) return nil;
    
    // create the paragraph style so the text alignment can be assigned to the attributed string.
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = alignment;
    
    // create the dictionary of attributes for the attributed string contaning the font and the paragraph style with the text alignment.
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle };
    
    // create the attributed string.
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    
    // create path for attributed string.
    return [self pathForMultilineAttributedString:attrString maxWidth:maxWidth];
}


#pragma mark - NSAttributedString


+ (UIBezierPath *)pathForAttributedString:(NSAttributedString *)string
{
    // if there is no specified string then there will be no path so just return nil.
    if (!string) return nil;
    
    // create the path from the specified string.
    CGPathRef letters = CGPathCreateSingleLineStringWithAttributedString(string);
    
    // make an iOS UIBezierPath object from the CGPath.
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letters];
    
    // release the created CGPath.
    CGPathRelease(letters);
    
    return path;
}


+ (UIBezierPath *)pathForMultilineAttributedString:(NSAttributedString *)string maxWidth:(CGFloat)maxWidth
{
    // if there is no specified string or the maxwidth is set to 0 then there will be no path so return nil.
    if (!string || maxWidth <= 0.0) return nil;
    
    // create the path from the specified string.
    CGPathRef letters = CGPathCreateMultilineStringWithAttributedString(string, maxWidth, MAX_HEIGHT_OF_FRAME);
    
    // make an iOS UIBezierPath object from the CGPath.
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letters];
    
    // release the created CGPath.
    CGPathRelease(letters);
    
    return path;
}


@end
