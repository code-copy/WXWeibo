//
//  WeiboAnnotation.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/18.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboAnnotation.h"
#import "WeiboModel.h"

@implementation WeiboAnnotation

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    
    self = [super init];
    
    if (self) {
        _coordinate = coordinate;
    }
    return self;
}

- (instancetype)initWithWeiboModel:(WeiboModel *)weiboModel {
    
    if (self = [super init]) {
        
        self.weiboModel = weiboModel;
        NSDictionary *geo = weiboModel.geo;
        
        NSArray *coordinates = geo[@"coordinates"];
        if (coordinates.count >= 2) {
            NSString *latitude = coordinates[0];
            NSString *longitude = coordinates[1];
            
            _coordinate = CLLocationCoordinate2DMake([latitude floatValue], [longitude floatValue]);
        }
        
        
    }
    
    return self;
}



@end
