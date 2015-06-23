//
//  DeeMusic.h
//  musicPlayer
//
//  Created by Dee on 15/6/20.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeeMusic : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString *filename;
@property (nonatomic,copy)NSString *singer;
@property (nonatomic,copy)NSString *singerIcon;
@property (copy, nonatomic) NSString *icon;
+(instancetype)musicWithDic:(NSDictionary*)dic;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
