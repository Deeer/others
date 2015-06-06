//
//  ViewController.m
//  高德Demo
//
//  Created by Dee on 15/6/6.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#define APIKey @"89b0c2dac522dd0cc999ed2dae9e7491"

@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    UIButton *_locationBtn;
}

@end

@implementation ViewController
-(void)initSearch
{
    _search =[[AMapSearchAPI alloc]initWithSearchKey:APIKey Delegate:self];
}

-(void)initControls
{
    _locationBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame =CGRectMake(20, CGRectGetHeight(_mapView.bounds)-120, 40, 40);
    _locationBtn.autoresizingMask= UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    _locationBtn.backgroundColor =[UIColor whiteColor];
    _locationBtn.layer.cornerRadius = 5;
    [_locationBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn setImage:[UIImage imageNamed:@"lineDashTexture"] forState:UIControlStateNormal];
    _locationBtn.backgroundColor =[UIColor redColor];
    [self.view addSubview:_locationBtn];
    
}
-(void)locationAction
{
    if(_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
    
}
-(void)initMapView
{
//    _mapView.customizeUserLocationAccuracyCircleRepresentation= YES;
    [MAMapServices sharedServices].apiKey= APIKey;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate=self;
    
    
    _mapView.compassOrigin =CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);
    [self.view addSubview:_mapView];
    
    
}
-(void)reGeoaction
{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc]init];
        request.location =[AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}

- (void)viewDidLoad {
    
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
      _mapView.showsUserLocation =YES;
    [self initMapView];
    [self locationAction];
    [self initSearch];
    [self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    CLLocation *currentLocation =userLocation.location;
    _currentLocation = [userLocation.location copy];
    NSLog(@"%@",currentLocation);
    NSLog(@"----");
    
    
}
-(void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"request:%@--error:%@",request,error);
    
}
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"response:%@",response);
    NSString *title =response.regeocode.addressComponent.city;
    if (title.length==0) {
        title =response.regeocode.addressComponent.province;
    }
    _mapView.userLocation.title =title;
    _mapView.userLocation.subtitle =response.regeocode.formattedAddress;
    
}
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self reGeoaction];
    }
}

@end
