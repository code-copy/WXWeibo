//
//  WeiboAnnotationView.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/18.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <MapKit/MapKit.h>

@class WXLabel;
@interface WeiboAnnotationView : MKAnnotationView {
    //子视图
    
    //1.微博图片
    UIImageView *_weiboImg;
    //2.用户头像
    UIImageView *_userImg;
    
    //3.微博内容
    WXLabel *_textLabel;
}


@end
