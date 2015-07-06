//
//  ViewController.m
//  button
//
//  Created by Dee on 15/7/3.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn=[[UIButton alloc]init];
    btn.backgroundColor =[UIColor redColor];
    btn.frame =CGRectMake(100, 100, 60, 60);
    btn.layer.cornerRadius = 30;
    [self.view addSubview:btn];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
