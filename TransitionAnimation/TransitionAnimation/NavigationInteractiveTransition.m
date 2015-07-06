//
//  NavigationInteractiveTransition.m
//  TransitionAnimation
//
//  Created by Dee on 15/7/6.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import "NavigationInteractiveTransition.h"
#import "PopAnimation.h"
@interface NavigationInteractiveTransition ()


@property(nonatomic,weak)UINavigationController *vc ;
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;


@end

@implementation NavigationInteractiveTransition

-(instancetype)initWithViewController:(UIViewController*)vc
{
    if (self = [super init]) {
       
        self.vc  = (UINavigationController *)vc;
        self.vc.delegate= self;
    }
    return self;
}

-(void)handleControllerPop:(UIPanGestureRecognizer*)recognizer
{
    CGFloat progress =[recognizer translationInView:recognizer.view].x/recognizer.view.bounds.size.width;
    progress =MIN(1.0, MAX(0.0, progress));
    NSLog(@"111111");
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"222222");
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.vc popViewControllerAnimated:YES];
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
   
        [self.interactivePopTransition updateInteractiveTransition:progress];

        
    }else if(recognizer.state ==UIGestureRecognizerStateEnded ||recognizer.state == UIGestureRecognizerStateCancelled)
    {
        if ( progress >0.5 ) {
            [self.interactivePopTransition finishInteractiveTransition];
        }else
        {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
        
        
        
    }
    
}
-(nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(nonnull UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(nonnull UIViewController *)fromVC toViewController:(nonnull UIViewController *)toVC
{
    if ( operation == UINavigationControllerOperationPop)
        return  [[PopAnimation alloc]init];
    return  nil;
}

-(nullable id<UIViewControllerInteractiveTransitioning>)navigationController:(nonnull UINavigationController *)navigationController interactionControllerForAnimationController:(nonnull id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[PopAnimation class]]) {
        return self.interactivePopTransition;
    }
    return  nil;
}





@end
