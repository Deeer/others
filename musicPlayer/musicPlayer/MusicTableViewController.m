//
//  MusicTableViewController.m
//  musicPlayer
//
//  Created by Dee on 15/6/20.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "MusicTableViewController.h"
#import "DeeMusic.h"
#import <AVFoundation/AVFoundation.h>
#import "DeeAudioTool.h"
#import <MediaPlayer/MediaPlayer.h>
@interface MusicTableViewController ()<AVAudioPlayerDelegate>
@property (nonatomic,strong)NSArray *musics;
@property (nonatomic,strong)AVAudioPlayer *audioPlayer;
@property (nonatomic,strong)CADisplayLink *link;
@property (nonatomic,strong)AVAudioPlayer  *currentPlayingAudioPlayer;
- (IBAction)Jump:(id)sender;
@end

@implementation MusicTableViewController
-(CADisplayLink *)link
{
    if (!_link) {
        
        self.link =  [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}

-(NSArray *)musics
{
    if (_musics==nil) {
        NSString *path =[[NSBundle mainBundle]pathForResource:@"Musics.plist" ofType:nil];
        NSArray *arr =[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArr =[NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            DeeMusic *model =[[DeeMusic alloc]initWithDic:dic];
            [tempArr addObject:model];
        }
        _musics = tempArr;
        
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

  
}

-(void)update
{
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSIndexPath *selectPath = [self.tableView indexPathForSelectedRow];
    int nextRow = (int)selectPath.row +1;
    
    if (nextRow ==self.musics.count) {
     
        nextRow = 0;
    }
    NSIndexPath *currentPath =[NSIndexPath indexPathForRow:nextRow inSection:selectPath.section];
    
    [self.tableView selectRowAtIndexPath:currentPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:currentPath];

}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        return  self.musics.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"Music";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    DeeMusic *model =self.musics[indexPath.row];
    
    cell.textLabel.text  = model.name;
    cell.detailTextLabel.text = model.filename;
    cell.imageView.image =[UIImage imageNamed:
                           model.singerIcon];
    
    
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeeMusic *music =self.musics[indexPath.row];
    [DeeAudioTool stopMusic:music.filename];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeeMusic *music =self.musics[indexPath.row];
    AVAudioPlayer *player= [DeeAudioTool playMusic:music.filename];
    player.delegate =self;
    self.currentPlayingAudioPlayer = player;
    

    //在播放界面显示歌词
    [self showLockScreen:music];

    [self.link invalidate];
     self.link =nil;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
-(void)showLockScreen:(DeeMusic *)music
{
    NSMutableDictionary *info =[NSMutableDictionary dictionary];
    info[MPMediaItemPropertyAlbumTitle] = music.name;
    info[MPMediaItemPropertyArtist] = music.singer;
    info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:music.singerIcon]];
    [MPNowPlayingInfoCenter  defaultCenter].nowPlayingInfo = info;
}
#pragma mark-avaudioPlayer

/**
 * 音乐被打断（打\接电话）
 */
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    

    
    
}
/**
 *  音乐结束打断
 */
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    
}


- (IBAction)Jump:(id)sender {
    self.currentPlayingAudioPlayer.currentTime += 100;
}
@end
