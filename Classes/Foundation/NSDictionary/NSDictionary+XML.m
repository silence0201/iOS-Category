//
//  NSDictionary+XML.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NSDictionary+XML.h"

@implementation NSDictionary (XML)

- (NSString *)XMLString {
    
    return [self  XMLStringWithRootElement:nil declaration:nil];
}
- (NSString*)XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement{
    return [self  XMLStringWithRootElement:rootElement declaration:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"];
    
}
- (NSString*)XMLStringWithRootElement:(NSString*)rootElement declaration:(NSString*)declaration{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    if (declaration) {
        [xml appendString:declaration];
    }
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"<%@>",rootElement]];
    }
    [self convertNode:self withString:xml andTag:nil];
    if (rootElement) {
        [xml appendString:[NSString stringWithFormat:@"</%@>",rootElement]];
    }
    NSString *finalXML=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return finalXML;
}

- (void)convertNode:(id)node withString:(NSMutableString *)xml andTag:(NSString *)tag{
    if ([node isKindOfClass:[NSDictionary class]] && !tag) {
        NSArray *keys = [node allKeys];
        for (NSString *key in keys) {
            [self convertNode:[node objectForKey:key] withString:xml andTag:key];
        }
    }else if ([node isKindOfClass:[NSArray class]]) {
        for (id value in node) {
            [self convertNode:value withString:xml andTag:tag];
        }
    }else {
        [xml appendString:[NSString stringWithFormat:@"<%@>", tag]];
        if ([node isKindOfClass:[NSString class]]) {
            [xml appendString:node];
        }else if ([node isKindOfClass:[NSDictionary class]]) {
            [self convertNode:node withString:xml andTag:nil];
        }
        [xml appendString:[NSString stringWithFormat:@"</%@>", tag]];
    }
}



@end
