//
//  DeeMusic.m
//  musicPlayer
//
//  Created by Dee on 15/6/20.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "DeeMusic.h"

@implementation DeeMusic
+(instancetype)musicWithDic:(NSDictionary *)dic
{
    return  [[self alloc]initWithDic:dic];
    
}
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self =[super init]) {
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
}

@end
