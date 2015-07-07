//
//  ViewController.m
//  CLLocation
//
//  Created by Dee on 15/7/7.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong)    CLLocationManager *mgr ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    self.mgr.delegate = self ;
    if ([[UIDevice currentDevice].systemVersion floatValue]>8.0) {
        [self.mgr requestAlwaysAuthorization];
    }
    [self.mgr startUpdatingLocation];

}
#pragma mark -delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//    NSLog(@"%@",locations);
//    CLLocation 还有以下属性
    /*
     location.coordinate
              altitude //海拔
              course  //前进方向 ，0表示北，90表示东，180表示南，270表示西
              horizontalAccuracy 水平精准度
              verticalAccuracy  垂直精准度
              timestamp //定西信息时返回的时间戳
              speed //设备移动速度 单位是米/秒 适用于行车速度，不适用于步行
     
     */
    
    
    CLLocation *location =[locations lastObject];
    NSLog(@"%f-%f",location.coordinate.latitude,location.coordinate.longitude);
}

#pragma lazy
-(CLLocationManager *)mgr
{
    if (!_mgr) {
        _mgr =[[CLLocationManager alloc]init];
        
    }
    return  _mgr;
}



@end
