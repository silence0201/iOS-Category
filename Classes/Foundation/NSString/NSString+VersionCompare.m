//
//  NSString+VersionCompare.m
//  Category
//
//  Created by Silence on 2018/1/18.
//  Copyright © 2018年 silence. All rights reserved.
//

#import "NSString+VersionCompare.h"

static NSString *versionSeparator = @".";

@implementation NSString (VersionCompare)

-(NSComparisonResult)compareToVersion:(NSString *)version{
    NSComparisonResult result;
    
    result = NSOrderedSame;
    
    if(![self isEqualToString:version]){
        NSArray *thisVersion = [self componentsSeparatedByString:versionSeparator];
        NSArray *compareVersion = [version componentsSeparatedByString:versionSeparator];
        
        for(NSInteger index = 0; index < MAX([thisVersion count], [compareVersion count]); index++){
            NSInteger thisSegment = (index < [thisVersion count]) ? [[thisVersion objectAtIndex:index] integerValue] : 0;
            NSInteger compareSegment = (index < [compareVersion count]) ? [[compareVersion objectAtIndex:index] integerValue] : 0;
            
            if(thisSegment < compareSegment){
                result = NSOrderedAscending;
                break;
            }
            
            if(thisSegment > compareSegment){
                result = NSOrderedDescending;
                break;
            }
        }
    }
    
    return result;
}


-(BOOL)isOlderThanVersion:(NSString *)version{
    return ([self compareToVersion:version] == NSOrderedAscending);
}

-(BOOL)isNewerThanVersion:(NSString *)version{
    return ([self compareToVersion:version] == NSOrderedDescending);
}

-(BOOL)isEqualToVersion:(NSString *)version{
    return ([self compareToVersion:version] == NSOrderedSame);
}

-(BOOL)isEqualOrOlderThanVersion:(NSString *)version{
    return ([self compareToVersion:version] != NSOrderedDescending);
}

-(BOOL)isEqualOrNewerThanVersion:(NSString *)version{
    return ([self compareToVersion:version] != NSOrderedAscending);
}

- (NSString *)getMainVersionWithIntegerCount:(NSInteger)integerCount {
    NSArray *components = [self componentsSeparatedByString:versionSeparator];
    
    if((integerCount > 0) && (integerCount <= components.count)){
        return [[components subarrayWithRange:NSMakeRange(0, integerCount)] componentsJoinedByString:versionSeparator];
    }
    
    return NULL;
}

- (BOOL)needsToUpdateToVersion:(NSString *)newVersion mainVersionIntegerCount:(NSInteger)integerCount {
    NSString *myMainVersion = [self getMainVersionWithIntegerCount:integerCount];
    NSString *newMainVersion = [newVersion getMainVersionWithIntegerCount:integerCount];
    
    if ([myMainVersion isEqualToVersion:newMainVersion]) {
        return [newVersion isNewerThanVersion:self];
    }
    
    return NO;
}

@end
