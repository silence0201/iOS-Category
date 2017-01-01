//
//  UIFont+Traits.m
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIFont+Traits.h"
#import <CoreText/CoreText.h>

@implementation UIFont (Traits)

- (BOOL)isBold {
    if (![self respondsToSelector:@selector(fontDescriptor)]) return NO;
    return (self.fontDescriptor.symbolicTraits & UIFontDescriptorTraitBold) > 0;
}

- (BOOL)isItalic {
    if (![self respondsToSelector:@selector(fontDescriptor)]) return NO;
    return (self.fontDescriptor.symbolicTraits & UIFontDescriptorTraitItalic) > 0;
}

- (BOOL)isMonoSpace {
    if (![self respondsToSelector:@selector(fontDescriptor)]) return NO;
    return (self.fontDescriptor.symbolicTraits & UIFontDescriptorTraitMonoSpace) > 0;
}

- (BOOL)isColorGlyphs {
    if (![self respondsToSelector:@selector(fontDescriptor)]) return NO;
    return (CTFontGetSymbolicTraits((__bridge CTFontRef)self) & kCTFontTraitColorGlyphs) != 0;
}

- (CGFloat)fontWeight {
    NSDictionary *traits = [self.fontDescriptor objectForKey:UIFontDescriptorTraitsAttribute];
    return [traits[UIFontWeightTrait] floatValue];
}


@end
