//
//  PopAnimation.m
//  TransitionAnimation
//
//  Created by Dee on 15/7/6.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import "PopAnimation.h"

@interface PopAnimation ()

@property (nonatomic,strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation PopAnimation
-(NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}
-(void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromController =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController =[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *contrainView =[transitionContext containerView];
    
    [contrainView insertSubview: toController.view aboveSubview:fromController.view];
    NSTimeInterval duration =[self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
        fromController.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
        
        
    }completion:^(BOOL finished) {
        

        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}
-(void)animationDidStop:(nonnull CAAnimation *)anim finished:(BOOL)flag
{
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}


@end
