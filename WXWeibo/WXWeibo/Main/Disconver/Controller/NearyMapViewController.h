//
//  NearyMapViewController.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/17.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearyMapViewController : BaseController<MKMapViewDelegate,CLLocationManagerDelegate> {
    
    MKMapView *_mapView;
    NSMutableArray *_weiboAnnoations;
}

@end
