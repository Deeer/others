//
//  Persson.m
//  消息转发
//
//  Created by Dee on 15/6/5.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "Persson.h"
#import "Car.h"
@implementation Persson

//void run (id self ,SEL _cmd)
//{
//    NSLog(@"%@ -- %s",self,sel_getName(_cmd));
//}


+(BOOL)resolveInstanceMethod:(SEL)sel
{
//    NSLog(@"aa");
//    
//    
//    if (sel ==@selector(run)) {
//        
//        class_addMethod(self, sel, (IMP)run, "v@:");
//        return YES;
//    }
    NSLog(@"resolveInstanceMethod");
    
    return [super resolveInstanceMethod:sel];
}


//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//
//    return [[Car alloc]init];
//    
//}

 -(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSLog(@"--methodSignatureForSelector");
    NSString *sel =NSStringFromSelector(aSelector);
    if ([sel isEqualToString:@"run"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}


-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector =[anInvocation selector];

    Car *car =[[Car alloc]init];
    if ([car respondsToSelector:selector])
        [anInvocation invokeWithTarget:car];
}

@end
