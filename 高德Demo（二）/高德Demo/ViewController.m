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

@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    NSArray *_pois;
    UITableView *_tableView;
    NSMutableArray *_annotations;
    UIButton *_locationBtn;
}

@end

@implementation ViewController
-(void)initAttributes
{
    _annotations = [NSMutableArray array];
    _pois= nil;
}

-(void)initSearch
{
    _search =[[AMapSearchAPI alloc]initWithSearchKey:APIKey Delegate:self];
}

-(void)initControls
{
    _locationBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _locationBtn.frame =CGRectMake(20, CGRectGetHeight(_mapView.bounds)-80, 40, 40);
    _locationBtn.autoresizingMask= UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    _locationBtn.backgroundColor =[UIColor whiteColor];
    _locationBtn.layer.cornerRadius = 5;
    [_locationBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn setImage:[UIImage imageNamed:@"lineDashTexture"] forState:UIControlStateNormal];
    _locationBtn.titleLabel.text =@"follow";
    _locationBtn.backgroundColor =[UIColor redColor];
    [_mapView addSubview:_locationBtn];
    
    
    UIButton *SearchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    SearchBtn.frame= CGRectMake(80, CGRectGetHeight(_mapView.bounds)-80, 40, 40);
    SearchBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    SearchBtn.backgroundColor =[UIColor purpleColor];
    [SearchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapView addSubview:SearchBtn];
    
    
}
-(void)initTableView
{
    CGFloat halfHeight =CGRectGetHeight(self.view.bounds)*0.5;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, halfHeight, CGRectGetHeight(self.view.bounds), halfHeight) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
}

-(void)searchAction
{
    
    if (_currentLocation ==nil||_search ==nil  ) {
        
        NSLog(@"search failed");
        return;
    }
    AMapPlaceSearchRequest *request =[[AMapPlaceSearchRequest alloc]init];
    request.searchType = AMapSearchType_PlaceAround;
    request.location =[AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    request.keywords =@"运动";
    [_search AMapPlaceSearch:request];
    
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
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)*0.5)];
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
    [self initTableView];
    [self initSearch];
    [self initControls];
    [self initAttributes];
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
-(void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    NSLog(@"request :%@",request);
    NSLog(@"responce :%@",response);
    
    if (response.pois.count>0) {
        _pois =response.pois;
        [_tableView reloadData];
        [_mapView removeAnnotations:_annotations];
        [_annotations removeAllObjects];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _pois.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID =@"spp";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    AMapPOI*poi =_pois[indexPath.row];
    cell.textLabel.text =poi.name;
    cell.detailTextLabel.text =poi.address;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapPOI *poi =_pois[indexPath.row];
    MAPointAnnotation *annotation =[[MAPointAnnotation alloc]init];
    annotation.coordinate =CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    annotation.title= poi.name;
    annotation.subtitle =poi.address;
    
    [_annotations addObject:annotation];
    [_mapView addAnnotation:annotation];
    
}
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
       static NSString*ID2 =@"anno";
        MAPinAnnotationView *annotationView=(MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:ID2];
        if (annotationView==nil) {
            annotationView =[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID2];
        }
        
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}
@end
