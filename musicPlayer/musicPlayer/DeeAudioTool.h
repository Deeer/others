//
//  DeeAudioTool.h
//  sound
//
//  Created by Dee on 15/6/17.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DeeAudioTool : NSObject

+(void)playSound:(NSString*)fileName;
+(void)disposeSond:(NSString*)fileName;


+(AVAudioPlayer *)playMusic:(NSString*)filename;
+(void)pauseMusic:(NSString*)filename;
+(void)stopMusic:(NSString*)filename;
+(AVAudioPlayer *)currentPlayingAudioPlayer;
@end
