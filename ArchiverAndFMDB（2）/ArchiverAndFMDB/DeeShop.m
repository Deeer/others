//
//  DeeShop.m
//  ArchiverAndFMDB
//
//  Created by Dee on 15/6/12.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "DeeShop.h"

@implementation DeeShop
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeDouble:self.price forKey:@"price"];

}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self= [super init]) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.price = [aDecoder decodeDoubleForKey: @"price"];
        
    }
    return self;
}
-(NSString *)description
{
//    NSLog(@"---%@",self.name);
//    NSLog(@"--%f",self.price);
    return  [NSString stringWithFormat:@"%@--%f",self.name,self.price];
//    return self.name;
}
@end
