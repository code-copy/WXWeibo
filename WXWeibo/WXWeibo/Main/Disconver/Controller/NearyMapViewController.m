//
//  NearyMapViewController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/17.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "NearyMapViewController.h"
#import "WeiboAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "MyDataService.h"
#import "WeiboModel.h"
#import "WeiboAnnotationView.h"
#import "DetailViewController.h"

@interface NearyMapViewController ()

@end

/*
 添加标注视图的步骤：
 1、定义Annotation类(Model)
 2、创建Annotation对象，将此对象添加到地图上MapView
 3、实现协议方法，在协议方法中创建标注视图
 */
@implementation NearyMapViewController {
    
    CLLocationManager *_locationManager;
    BOOL _isRegion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    /*
     MKMapTypeStandard   标准地图
     MKMapTypeSatellite  卫星地图
     MKMapTypeHybrid     混合地图
     */
    _mapView.mapType = MKMapTypeStandard;
    
    //是否在地图上显示当前设备所在的位置
    _mapView.showsUserLocation = YES;
    
    _mapView.delegate = self;
    
    /*
    //放大地图，显示局部区域
    //范围的中心点经纬坐标
    CLLocationCoordinate2D center = {22.284681,114.158177};
    //范围的大小
    MKCoordinateSpan span = {0.01,0.01};
    
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
     */
    
    [self.view addSubview:_mapView];
    
    /*
    //向地图上添加Annotation对象
    CLLocationCoordinate2D coordinate = {22.284681,114.158377};
    WeiboAnnotation *annotation = [[WeiboAnnotation alloc] initWithCoordinate:coordinate];
    annotation.title = @"无限互联香港分校";
    [_mapView addAnnotation:annotation];
     */
    
    
    //定位当前设备的位置
    _locationManager = [[CLLocationManager alloc] init];
    //设置精准度
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
    
    
    
}

//请求附件的微博数据
- (void)_loadNearWeiboData:(NSString *)lon
                   latitue:(NSString *)latitude {
    
    NSDictionary *params = @{
                            @"lat":latitude,
                            @"long":lon
                        };
    
    
    [MyDataService requestURL:@"place/nearby_timeline.json" httpMethod:@"GET" params:params fileDatas:nil completion:^(id result) {
       
        NSArray *statuses = result[@"statuses"];
        
        _weiboAnnoations = [NSMutableArray arrayWithCapacity:statuses.count];
        
        for (NSDictionary *weiboJSON in statuses) {
            
            WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:weiboJSON];
            
            //为每一个微博Model，创建一个标注
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] initWithWeiboModel:weibo];
            [_weiboAnnoations addObject:annotation];

        }
        
        //UI展示数据
        //[_mapView addAnnotations:weibos];
        
    }];
    
}

#pragma mark - CLLocationManager delegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    //1.停止定位
    [manager stopUpdatingLocation];
    
    //2.取得位置坐标
    CLLocation *location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //3.请求数据
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    
    [self _loadNearWeiboData:lon latitue:lat];
    
    
}

#pragma mark - MKMapView delegate
//地图定位更新时，调用此协议方法
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    
//    CLLocationCoordinate2D center = {22.284681,114.158177};
    //范围的大小
    MKCoordinateSpan span = {0.05,0.05};
    
    MKCoordinateRegion region = {coordinate,span};
//    [_mapView setRegion:region];
    _isRegion = YES;
    [_mapView setRegion:region animated:NO];
}

/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //NSLog(@"%@",annotation);
    //判断是否是当前设备位置的标注，如果是，则返回nil，MapView会创建默认的标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //创建标注视图
    
    static NSString *identify = @"AnnotationView";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
        
        //设置大头针的颜色
        annotationView.pinColor = MKPinAnnotationColorGreen;
        
        //设置是否在大头针头部显示标题
//        annotationView.canShowCallout = YES;
        
        //添加标题右边辅助视图
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        //从天而降的动画效果
        annotationView.animatesDrop = YES;
        
//        annotationView.leftCalloutAccessoryView
        
    }
    annotationView.annotation = annotation;
    
    
    return annotationView;
}
 */

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    //判断是否是当前设备位置的标注，如果是，则返回nil，MapView会创建默认的标注视图
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identify = @"WeiboAnnotationView";
    
    WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    
    if (annotationView == nil) {
        annotationView = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify];
    }
    
    annotationView.annotation = annotation;
    
    return annotationView;
}


//选中标注视图
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if (![view isKindOfClass:[WeiboAnnotationView class]]) {
        return;
    }
    
    WeiboAnnotation *annotation = view.annotation;
    WeiboModel *weiboModel = annotation.weiboModel;
    
    //创建微博详情控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    DetailViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailVC.weiboModel = weiboModel;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (_isRegion) {
        
        [_mapView addAnnotations:_weiboAnnoations];
        
        _isRegion = NO;
    }
    
}

//添加了多个标注视图
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    //NSLog(@"%@",views);
    
    for (int i=0; i<views.count; i++) {
        WeiboAnnotationView *view = views[i];
        
        view.transform = CGAffineTransformMakeScale(0.5, 0.5);
        view.alpha = 0;
        
        //给标注视图添加动画
        //动画1：0  动画2：0.1  动画3：0.2  ...
        [UIView animateWithDuration:1.0f animations:^{
            
            [UIView setAnimationDelay:0.2*i];
            
            view.transform = CGAffineTransformMakeScale(1.2, 1.2);
            view.alpha = 1;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                view.transform = CGAffineTransformMakeScale(1, 1);
                
            }];
            
        }];
        
    }
    
}

@end
