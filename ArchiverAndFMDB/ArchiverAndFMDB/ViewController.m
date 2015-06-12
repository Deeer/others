//
//  ViewController.m
//  ArchiverAndFMDB
//
//  Created by Dee on 15/6/12.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "DeeShop.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addShop];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self readShops];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)readShops
{
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *aPath =[path stringByAppendingPathComponent:@"dee.data"];
    NSMutableArray *shops =[NSKeyedUnarchiver unarchiveObjectWithFile:aPath];
    
    NSLog(@"%@",[shops subarrayWithRange:NSMakeRange(20, 10)]);
}

-(void)addShop{
    
    NSMutableArray *shops =[NSMutableArray array];
    for (int i = 0 ; i<100; i++) {
        DeeShop *shop = [[DeeShop alloc]init];
        shop.name = [NSString stringWithFormat:@"com--%d",i];
        shop.price = arc4random() % 10000;
        [shops addObject:shop];
    }
    
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *aPath =[path stringByAppendingPathComponent:@"dee.data"];
    
    [NSKeyedArchiver archiveRootObject:shops toFile:aPath];
    
}

@end
