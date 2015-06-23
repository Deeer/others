//
//  ViewController.m
//  FileManager
//
//  Created by Dee on 15/6/22.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)fileSize
{
    //文件
    NSFileManager *manager =[NSFileManager defaultManager];
    //缓存
    NSString *caches =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //获得缓存文件下的所有文件路径
    NSArray *subpaths=[manager subpathsAtPath:caches];
    //初始化bitSize容器，方便以后计算
    NSInteger totalBytesSize = 0;
    //遍历所有的路径字符串
    for (NSString *subPath in subpaths) {
        //将字符串拼接到caches后面
        NSString *fullPath =[caches stringByAppendingPathComponent:subPath];
        //判断是文件夹还是路径
        BOOL dir = NO;
        
        [manager fileExistsAtPath:fullPath isDirectory:&dir];
        
        if (dir == NO) {
            totalBytesSize += [[manager attributesOfItemAtPath:fullPath error:nil][NSFileSize] integerValue];
        }
    }
    
    NSLog(@"%ld",(long)totalBytesSize);
}
@end
