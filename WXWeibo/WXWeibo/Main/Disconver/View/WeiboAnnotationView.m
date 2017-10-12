//
//  WeiboAnnotationView.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/18.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WXLabel.h"
#import "WeiboAnnotation.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self _createView];
        
    }
    return self;
}

- (void)_createView {
    
    _weiboImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_weiboImg];
    
    _userImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImg.layer.borderWidth = 1;
    _userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:_userImg];
    
    _textLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
    _textLabel.font = [UIFont systemFontOfSize:12];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.backgroundColor = [UIColor grayColor];
    _textLabel.numberOfLines = 3;
    [self addSubview:_textLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (![self.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    WeiboAnnotation *weiboAnnotation = (WeiboAnnotation *)self.annotation;
    WeiboModel *weiboModel = weiboAnnotation.weiboModel;
    
    //取得微博图片
    NSString *thumbnail_pic = weiboModel.thumbnail_pic;
    if (thumbnail_pic.length > 0) { //有微博图片
        //设置背景图片
        self.image = [UIImage imageNamed:@"nearby_map_photo_bg.png"];
        _textLabel.hidden = YES;
        _weiboImg.hidden = NO;
        
        //1.微博图片
        _weiboImg.frame = CGRectMake(15, 15, 90, 85);
        [_weiboImg setImageWithURL:[NSURL URLWithString:thumbnail_pic]];
        
        //2.头像
        _userImg.frame = CGRectMake(70, 70, 30, 30);
        NSString *profileURL = weiboModel.user.profile_image_url;
        [_userImg setImageWithURL:[NSURL URLWithString:profileURL]];
        
    } else {
        //设置背景图片
        self.image = [UIImage imageNamed:@"nearby_map_content.png"];
        _textLabel.hidden = NO;
        _weiboImg.hidden = YES;
        
        //1.用户头像
        _userImg.frame = CGRectMake(20, 20, 45, 45);
        NSString *profileURL = weiboModel.user.profile_image_url;
        [_userImg setImageWithURL:[NSURL URLWithString:profileURL]];
        
        //2.微博内容
        _textLabel.frame = CGRectMake(_userImg.right+5, _userImg.top, 110, 45);
        _textLabel.text = weiboModel.text;
    }
    
}

@end
