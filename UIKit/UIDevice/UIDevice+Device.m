//
//  UIDevice+Device.m
//  Category
//
//  Created by 杨晴贺 on 01/01/2017.
//  Copyright © 2017 silence. All rights reserved.
//

#import "UIDevice+Device.h"
#include <sys/sysctl.h>

NSString* const iPhone1_1 = @"iPhone1,1";
NSString* const iPhone1_2 = @"iPhone1,2";
NSString* const iPhone2_1 = @"iPhone2,1";
NSString* const iPhone3_1 = @"iPhone3,1";
NSString* const iPhone3_2 = @"iPhone3,2";
NSString* const iPhone3_3 = @"iPhone3,3";
NSString* const iPhone4_1 = @"iPhone4,1";
NSString* const iPhone5_1 = @"iPhone5,1";
NSString* const iPhone5_2 = @"iPhone5,2";
NSString* const iPhone5_3 = @"iPhone5,3";
NSString* const iPhone5_4 = @"iPhone5,4";
NSString* const iPhone6_1 = @"iPhone6,1";
NSString* const iPhone6_2 = @"iPhone6,2";
NSString* const iPhone7_1 = @"iPhone7,1";
NSString* const iPhone7_2 = @"iPhone7,2";
NSString* const iPhone8_1 = @"iPhone8,1";
NSString* const iPhone8_2 = @"iPhone8,2";
NSString* const iPhone8_4 = @"iPhone8,4";

NSString* const iPod1_1 = @"iPod1,1";
NSString* const iPod2_1 = @"iPod2,1";
NSString* const iPod3_1 = @"iPod3,1";
NSString* const iPod4_1 = @"iPod4,1";
NSString* const iPod5_1 = @"iPod5,1";
NSString* const iPod7_1 = @"iPod7,1";

NSString* const iPad1_1 = @"iPad1,1";
NSString* const iPad1_2 = @"iPad1,2";
NSString* const iPad2_1 = @"iPad2,1";
NSString* const iPad2_2 = @"iPad2,2";
NSString* const iPad2_3 = @"iPad2,3";
NSString* const iPad2_4 = @"iPad2,4";
NSString* const iPad2_5 = @"iPad2,5";
NSString* const iPad2_6 = @"iPad2,6";
NSString* const iPad2_7 = @"iPad2,7";
NSString* const iPad3_1 = @"iPad3,1";
NSString* const iPad3_2 = @"iPad3,2";
NSString* const iPad3_3 = @"iPad3,3";
NSString* const iPad3_4 = @"iPad3,4";
NSString* const iPad3_5 = @"iPad3,5";
NSString* const iPad3_6 = @"iPad3,6";
NSString* const iPad4_1 = @"iPad4,1";
NSString* const iPad4_2 = @"iPad4,2";
NSString* const iPad4_3 = @"iPad4,3";
NSString* const iPad4_4 = @"iPad4,4";
NSString* const iPad4_5 = @"iPad4,5";
NSString* const iPad4_6 = @"iPad4,6";
NSString* const iPad4_7 = @"iPad4,7";
NSString* const iPad4_8 = @"iPad4,8";
NSString* const iPad4_9 = @"iPad4,9";
NSString* const iPad5_1 = @"iPad5,1";
NSString* const iPad5_2 = @"iPad5,2";
NSString* const iPad5_3 = @"iPad5,3";
NSString* const iPad5_4 = @"iPad5,4";
NSString* const iPad6_3 = @"iPad6,3";
NSString* const iPad6_4 = @"iPad6,4";
NSString* const iPad6_7 = @"iPad6,7";
NSString* const iPad6_8 = @"iPad6,8";

NSString* const i386_Sim    = @"i386";
NSString* const x86_64_Sim  = @"x86_64";

@implementation UIDevice (Device)

- (BOOL)isPad {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}

- (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

- (BOOL)isJailbroken {
    if ([self isSimulator]) return NO; 
    
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt/",
                       @"/private/var/lib/cydia",
                       @"/private/var/stash"];
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
    }
    
    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uu = (__bridge_transfer NSString *)uuid;
    NSString *path = [NSString stringWithFormat:@"/private/%@",uu];
    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    
    return NO;
}

- (BOOL)isRetina{
    return ([UIScreen mainScreen].scale == 2.0f);
}

- (BOOL)hasCamera{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)canCallPhone{
    __block BOOL can;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        can = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
    });
    return can;
}

- (NSDate *)systemUptime{
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

- (NSString *)hardwareString{
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0);
    char *hw_machine = malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;

}

- (Hardware)hardware{
    NSString *hardware = self.hardwareString ;
    if ([hardware isEqualToString:iPhone1_1])    return IPHONE_2G;
    if ([hardware isEqualToString:iPhone1_2])    return IPHONE_3G;
    if ([hardware isEqualToString:iPhone2_1])    return IPHONE_3GS;
    
    if ([hardware isEqualToString:iPhone3_1])    return IPHONE_4;
    if ([hardware isEqualToString:iPhone3_2])    return IPHONE_4;
    if ([hardware isEqualToString:iPhone3_3])    return IPHONE_4_CDMA;
    if ([hardware isEqualToString:iPhone4_1])    return IPHONE_4S;
    
    if ([hardware isEqualToString:iPhone5_1])    return IPHONE_5;
    if ([hardware isEqualToString:iPhone5_2])    return IPHONE_5_CDMA_GSM;
    if ([hardware isEqualToString:iPhone5_3])    return IPHONE_5C;
    if ([hardware isEqualToString:iPhone5_4])    return IPHONE_5C_CDMA_GSM;
    if ([hardware isEqualToString:iPhone6_1])    return IPHONE_5S;
    if ([hardware isEqualToString:iPhone6_2])    return IPHONE_5S_CDMA_GSM;
    
    if ([hardware isEqualToString:iPhone7_1])    return IPHONE_6_PLUS;
    if ([hardware isEqualToString:iPhone7_2])    return IPHONE_6;
    if ([hardware isEqualToString:iPhone8_1])    return IPHONE_6S;
    if ([hardware isEqualToString:iPhone8_2])    return IPHONE_6S_PLUS;
    if ([hardware isEqualToString:iPhone8_4])    return IPHONE_SE;
    
    if ([hardware isEqualToString:iPod1_1])      return IPOD_TOUCH_1G;
    if ([hardware isEqualToString:iPod2_1])      return IPOD_TOUCH_2G;
    if ([hardware isEqualToString:iPod3_1])      return IPOD_TOUCH_3G;
    if ([hardware isEqualToString:iPod4_1])      return IPOD_TOUCH_4G;
    if ([hardware isEqualToString:iPod5_1])      return IPOD_TOUCH_5G;
    if ([hardware isEqualToString:iPod7_1])      return IPOD_TOUCH_6G;
    
    if ([hardware isEqualToString:iPad1_1])      return IPAD;
    if ([hardware isEqualToString:iPad1_2])      return IPAD_3G;
    if ([hardware isEqualToString:iPad2_1])      return IPAD_2_WIFI;
    if ([hardware isEqualToString:iPad2_2])      return IPAD_2;
    if ([hardware isEqualToString:iPad2_3])      return IPAD_2_CDMA;
    if ([hardware isEqualToString:iPad2_4])      return IPAD_2;
    if ([hardware isEqualToString:iPad2_5])      return IPAD_MINI_WIFI;
    if ([hardware isEqualToString:iPad2_6])      return IPAD_MINI;
    if ([hardware isEqualToString:iPad2_7])      return IPAD_MINI_WIFI_CDMA;
    if ([hardware isEqualToString:iPad3_1])      return IPAD_3_WIFI;
    if ([hardware isEqualToString:iPad3_2])      return IPAD_3_WIFI_CDMA;
    if ([hardware isEqualToString:iPad3_3])      return IPAD_3;
    if ([hardware isEqualToString:iPad3_4])      return IPAD_4_WIFI;
    if ([hardware isEqualToString:iPad3_5])      return IPAD_4;
    if ([hardware isEqualToString:iPad3_6])      return IPAD_4_GSM_CDMA;
    if ([hardware isEqualToString:iPad4_1])      return IPAD_AIR_WIFI;
    if ([hardware isEqualToString:iPad4_2])      return IPAD_AIR_WIFI_GSM;
    if ([hardware isEqualToString:iPad4_3])      return IPAD_AIR_WIFI_CDMA;
    if ([hardware isEqualToString:iPad4_4])      return IPAD_MINI_RETINA_WIFI;
    if ([hardware isEqualToString:iPad4_5])      return IPAD_MINI_RETINA_WIFI_CDMA;
    if ([hardware isEqualToString:iPad4_6])      return IPAD_MINI_RETINA_WIFI_CELLULAR_CN;
    if ([hardware isEqualToString:iPad4_7])      return IPAD_MINI_3_WIFI;
    if ([hardware isEqualToString:iPad4_8])      return IPAD_MINI_3_WIFI_CELLULAR;
    if ([hardware isEqualToString:iPad4_9])      return IPAD_MINI_3_WIFI_CELLULAR_CN;
    if ([hardware isEqualToString:iPad5_1])      return IPAD_MINI_4_WIFI;
    if ([hardware isEqualToString:iPad5_2])      return IPAD_MINI_4_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:iPad5_3])      return IPAD_AIR_2_WIFI;
    if ([hardware isEqualToString:iPad5_4])      return IPAD_AIR_2_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:iPad6_3])      return IPAD_PRO_97_WIFI;
    if ([hardware isEqualToString:iPad6_4])      return IPAD_PRO_97_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:iPad6_7])      return IPAD_PRO_WIFI;
    if ([hardware isEqualToString:iPad6_8])      return IPAD_PRO_WIFI_CELLULAR;
    
    if ([hardware isEqualToString:i386_Sim])         return SIMULATOR;
    if ([hardware isEqualToString:x86_64_Sim])       return SIMULATOR;
    
    return NOT_AVAILABLE;
}


- (NSString *)hardwareDesc{
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = self.hardwareString;
        if (!model) return;
        NSDictionary *dic = @{
                              @"Watch1,1" : @"Apple Watch 38mm",
                              @"Watch1,2" : @"Apple Watch 42mm",
                              @"Watch2,3" : @"Apple Watch Series 2 38mm",
                              @"Watch2,4" : @"Apple Watch Series 2 42mm",
                              @"Watch2,6" : @"Apple Watch Series 1 38mm",
                              @"Watch1,7" : @"Apple Watch Series 1 42mm",
                              
                              @"iPod1,1" : @"iPod touch 1",
                              @"iPod2,1" : @"iPod touch 2",
                              @"iPod3,1" : @"iPod touch 3",
                              @"iPod4,1" : @"iPod touch 4",
                              @"iPod5,1" : @"iPod touch 5",
                              @"iPod7,1" : @"iPod touch 6",
                              
                              @"iPhone1,1" : @"iPhone 1G",
                              @"iPhone1,2" : @"iPhone 3G",
                              @"iPhone2,1" : @"iPhone 3GS",
                              @"iPhone3,1" : @"iPhone 4 (GSM)",
                              @"iPhone3,2" : @"iPhone 4",
                              @"iPhone3,3" : @"iPhone 4 (CDMA)",
                              @"iPhone4,1" : @"iPhone 4S",
                              @"iPhone5,1" : @"iPhone 5",
                              @"iPhone5,2" : @"iPhone 5",
                              @"iPhone5,3" : @"iPhone 5c",
                              @"iPhone5,4" : @"iPhone 5c",
                              @"iPhone6,1" : @"iPhone 5s",
                              @"iPhone6,2" : @"iPhone 5s",
                              @"iPhone7,1" : @"iPhone 6 Plus",
                              @"iPhone7,2" : @"iPhone 6",
                              @"iPhone8,1" : @"iPhone 6s",
                              @"iPhone8,2" : @"iPhone 6s Plus",
                              @"iPhone8,4" : @"iPhone SE",
                              @"iPhone9,1" : @"iPhone 7",
                              @"iPhone9,2" : @"iPhone 7 Plus",
                              @"iPhone9,3" : @"iPhone 7",
                              @"iPhone9,4" : @"iPhone 7 Plus",
                              
                              @"iPad1,1" : @"iPad 1",
                              @"iPad2,1" : @"iPad 2 (WiFi)",
                              @"iPad2,2" : @"iPad 2 (GSM)",
                              @"iPad2,3" : @"iPad 2 (CDMA)",
                              @"iPad2,4" : @"iPad 2",
                              @"iPad2,5" : @"iPad mini 1",
                              @"iPad2,6" : @"iPad mini 1",
                              @"iPad2,7" : @"iPad mini 1",
                              @"iPad3,1" : @"iPad 3 (WiFi)",
                              @"iPad3,2" : @"iPad 3 (4G)",
                              @"iPad3,3" : @"iPad 3 (4G)",
                              @"iPad3,4" : @"iPad 4",
                              @"iPad3,5" : @"iPad 4",
                              @"iPad3,6" : @"iPad 4",
                              @"iPad4,1" : @"iPad Air",
                              @"iPad4,2" : @"iPad Air",
                              @"iPad4,3" : @"iPad Air",
                              @"iPad4,4" : @"iPad mini 2",
                              @"iPad4,5" : @"iPad mini 2",
                              @"iPad4,6" : @"iPad mini 2",
                              @"iPad4,7" : @"iPad mini 3",
                              @"iPad4,8" : @"iPad mini 3",
                              @"iPad4,9" : @"iPad mini 3",
                              @"iPad5,1" : @"iPad mini 4",
                              @"iPad5,2" : @"iPad mini 4",
                              @"iPad5,3" : @"iPad Air 2",
                              @"iPad5,4" : @"iPad Air 2",
                              @"iPad6,3" : @"iPad Pro (9.7 inch)",
                              @"iPad6,4" : @"iPad Pro (9.7 inch)",
                              @"iPad6,7" : @"iPad Pro (12.9 inch)",
                              @"iPad6,8" : @"iPad Pro (12.9 inch)",
                              
                              @"AppleTV2,1" : @"Apple TV 2",
                              @"AppleTV3,1" : @"Apple TV 3",
                              @"AppleTV3,2" : @"Apple TV 3",
                              @"AppleTV5,3" : @"Apple TV 4",
                              
                              @"i386" : @"Simulator x86",
                              @"x86_64" : @"Simulator x64",
                              };
        name = dic[model];
        if (!name) name = model;
    });
    return name;
}

- (DeviceFamily)deviceFamily{
    NSString *hardware = self.hardwareString ;
    if ([hardware hasPrefix:@"iPhone"])      return UIDeviceFamilyiPhone;
    if ([hardware hasPrefix:@"iPod"])        return UIDeviceFamilyiPod;
    if ([hardware hasPrefix:@"iPad"])        return UIDeviceFamilyiPad;
    if ([hardware hasPrefix:@"AppleTV"])     return UIDeviceFamilyAppleTV;
    
    return UIDeviceFamilyUnknown;
}



@end
