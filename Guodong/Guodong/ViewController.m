//
//  ViewController.m
//  Guodong
//
//  Created by Dee on 15/6/8.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import "secondViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
//@property(nonatomic,assign)int nDivision;

@property(nonatomic,strong)UIView *Aview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _Aview =[[UIView alloc]initWithFrame:CGRectMake(120, 120, 100, 100)];
    
    _Aview.backgroundColor =[UIColor purpleColor];
    [self.view  addSubview:_Aview];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    secondViewController *secViewcontroller= segue.destinationViewController;
    secViewcontroller.transitioningDelegate = self;
}


#pragma mark - TransitionDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return  
    
}



@end
