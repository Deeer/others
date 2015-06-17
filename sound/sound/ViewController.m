//
//  ViewController.m
//  sound
//
//  Created by Dee on 15/6/17.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DeeAudioTool.h"
@interface ViewController ()

@property(nonatomic,assign)SystemSoundID soundID;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    
    
}



-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
    
//    NSString *filename=[NSString stringWithFormat:@"m_%02d.wav",arc4random_uniform(14)+3];
    
// [DeeAudioTool playSound:filename];
    [DeeAudioTool playSound:@"lose.aac"];
    [DeeAudioTool playSound:@"buyao.aac"];
    
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [DeeAudioTool disposeSond:@"m_08.wav"];
}

@end
