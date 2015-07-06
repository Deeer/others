//
//  NavigationC.m
//  TransitionAnimation
//
//  Created by Dee on 15/7/6.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import "NavigationC.h"
#import "NavigationInteractiveTransition.h"
@interface NavigationC ()<UIGestureRecognizerDelegate>


@property(nonatomic,strong)NavigationInteractiveTransition *navT;

@end
@implementation NavigationC
-(void)viewDidLoad
{
    [super viewDidLoad];
    UIGestureRecognizer *recognizer = self.interactivePopGestureRecognizer;
    recognizer.enabled =NO;
    UIView *gestureView = recognizer.view;
    
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc]init];
    popRecognizer.delegate= self;
    popRecognizer.maximumNumberOfTouches =1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    _navT = [[NavigationInteractiveTransition alloc]initWithViewController:self];
    [popRecognizer addTarget:_navT action:@selector(handleControllerPop:)];
    
    
    
    
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
