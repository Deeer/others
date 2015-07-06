
//
//  NaViewController.m
//  手势切换
//
//  Created by Dee on 15/7/1.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "NaViewController.h"

@interface NaViewController ()

@property (nonatomic,strong)NSMutableArray *images;
@property (nonatomic,strong)UIImageView*lastView;
@end

@implementation NaViewController

-(NSMutableArray *)images
{
    if (!_images) {
    _images = [[NSMutableArray alloc]init];
    }
    return _images;
}
-(UIImageView *)lastView
{
    if (!_lastView) {
        self.lastView = [[UIImageView alloc]init];
    }
    return _lastView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"NaViewController");
    UIGestureRecognizer *recogn = self.interactivePopGestureRecognizer;
    NSLog(@"%@",recogn.view);
    
    UIPanGestureRecognizer *recognizer= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragging:)];
    
    [self.view addGestureRecognizer:recognizer];
//    NSLog(@"%d",self.images.count);
    
}
-(void)dragging:(UIPanGestureRecognizer*)recognizer
{
    if(self.viewControllers.count <=1) return;
    CGFloat tx =[recognizer translationInView:self.view].x;
    if(tx < 0)return;
    if (recognizer.state == UIGestureRecognizerStateCancelled||recognizer.state ==UIGestureRecognizerStateEnded) {
        
        CGFloat x =self.view.frame.origin.x;
        if (x>=self.view.frame.size.width*0.5) {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform =CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
            }completion:^(BOOL finished) {
                
//                [self popToRootViewControllerAnimated:NO];
                [self popViewControllerAnimated:NO];
                [self.lastView removeFromSuperview];
                
                self.view.transform = CGAffineTransformIdentity;
                
                [self.images removeLastObject];
                
            }];
            
            
        }else
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            }];
        }
        
    }else
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.view.transform =CGAffineTransformMakeTranslation(tx, 0);
        self.lastView.image =self.images[self.images.count -2];
        self.lastView.frame =window.bounds ;
        [window insertSubview:self.lastView atIndex:0];
        
    }
    
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    [super pushViewController:viewController animated:animated];
    [self screenShoot];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.images.count>0) {
        return;
    }
    [self screenShoot];
    
}
-(void)screenShoot
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
    [self.view .layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    [self.images addObject:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
