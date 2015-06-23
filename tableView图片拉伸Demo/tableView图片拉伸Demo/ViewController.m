//
//  ViewController.m
//  tableView图片拉伸Demo
//
//  Created by Dee on 15/6/23.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak)UIImageView*topView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.tableView.contentInset  = UIEdgeInsetsMake(150,0, 0,0);
    
    UIImageView *imageView= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heisencat"]];
    imageView.frame =CGRectMake(0, -300, 300, 320);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.topView =imageView;
    [self.tableView insertSubview:self.topView atIndex:0];

//    [self.tableView addSubview:self.topView];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*ID =@"ta";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if ( !cell ) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.textLabel.text= @"----测试数据";
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat down = -150 - scrollView.contentOffset.y;
    if (down<0) return;
    CGRect frame = self.topView.frame ;
    frame.size.height = 320 +down;
    self.topView.frame= frame;
    

 
}
@end
