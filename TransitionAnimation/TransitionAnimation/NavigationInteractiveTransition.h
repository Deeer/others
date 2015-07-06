//
//  NavigationInteractiveTransition.h
//  TransitionAnimation
//
//  Created by Dee on 15/7/6.
//  Copyright © 2015年 zjsruxxxy7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class UIViewController,UIPercentDrivenInteractiveTransition;

@interface NavigationInteractiveTransition : NSObject<UINavigationControllerDelegate>

-(instancetype)initWithViewController:(UIViewController*)vc;

-(void)handleControllerPop:(UIPanGestureRecognizer*)recognizer;

-(UIPercentDrivenInteractiveTransition *)interactivePopTransition;

@end
