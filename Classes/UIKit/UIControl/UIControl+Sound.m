//
//  UIControl+Sound.m
//  Category
//
//  Created by 杨晴贺 on 2017/3/18.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIControl+Sound.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

static char const * const SoundsKey = "SoundsKey";
@implementation UIControl (Sound)

- (void)setSoundNamed:(NSString *)name forControlEvent:(UIControlEvents)controlEvent{
    // Remove the old UI sound.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat"
    NSString *oldSoundKey = [NSString stringWithFormat:@"%lu", controlEvent];
#pragma clang diagnostic pop
    AVAudioPlayer *oldSound = [self sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];
    
    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    NSString *file = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error = nil;
    
    AVAudioPlayer *tapSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wformat"
    NSString *controlEventKey = [NSString stringWithFormat:@"%lu", controlEvent];
#pragma clang diagnostic pop
    NSMutableDictionary *sounds = [self sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];
    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}


#pragma mark - Associated objects setters/getters

- (void)setSounds:(NSMutableDictionary *)sounds{
    objc_setAssociatedObject(self, SoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)sounds{
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, SoundsKey);
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        [self setSounds:sounds];
    }
    return sounds;
}


@end
