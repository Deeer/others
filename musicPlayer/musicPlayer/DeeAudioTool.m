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
//存放soundID
//存放音乐播放器
static NSMutableDictionary*_audioPlayerDict;

+(void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
    _audioPlayerDict = [NSMutableDictionary dictionary];
    //设置音频会话类型
    AVAudioSession *session =[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setActive:YES error:nil];
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
+(AVAudioPlayer *)playMusic:(NSString *)filename
{
    if (!filename) return nil;
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if (!audioPlayer) {
        NSURL *url = [[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url) return nil;
        
        audioPlayer  = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        [audioPlayer prepareToPlay];
        
//        audioPlayer.enableRate = YES;
//        audioPlayer.rate =10.0;
        _audioPlayerDict[filename] = audioPlayer;

    }
    if (!audioPlayer.isPlaying) {
    [audioPlayer play];
    }
    
    
    return audioPlayer;
    
}
+(void)pauseMusic:(NSString *)filename
{
    if (!filename)return;
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if (audioPlayer.isPlaying) {
        [audioPlayer  pause];
    }
}
+(void)stopMusic:(NSString *)filename
{
    if (!filename) return;
    AVAudioPlayer *audioPlayer =_audioPlayerDict[filename];
    if (audioPlayer.isPlaying) {
        [audioPlayer stop];
        [_audioPlayerDict removeObjectForKey:filename];
    }
    
}
+(AVAudioPlayer *)currentPlayingAudioPlayer
{
    for (NSString *fileName in _audioPlayerDict) {
        
        AVAudioPlayer *audioPlayer =_audioPlayerDict[fileName];
        if (audioPlayer.isPlaying) {
            return  audioPlayer;
        }
        
    }
    return nil;
}
@end
