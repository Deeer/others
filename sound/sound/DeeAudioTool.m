//
//  DeeAudioTool.m
//  sound
//
//  Created by Dee on 15/6/17.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import "DeeAudioTool.h"
#import <AVFoundation/AVFoundation.h>
@implementation DeeAudioTool

static NSMutableDictionary*_soundIDDict;
+(void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
}

+(void)playSound:(NSString *)fileName
{
    //从字典中取出soundID
    if(!fileName) return;
    SystemSoundID  soundID = [_soundIDDict[fileName] unsignedIntValue];
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        if (!url) return;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef __nonnull)(url), &soundID);
        
        _soundIDDict[fileName] =@(soundID);
    }
    
    AudioServicesPlaySystemSound(soundID);
    
}
+(void)disposeSond:(NSString *)fileName
{
   SystemSoundID  soundID = [_soundIDDict[fileName] unsignedIntValue];
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [_soundIDDict removeObjectForKey:fileName];
    }
    
}

@end
