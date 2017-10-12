//
//  MainTabbarController.h
//  WXMovie
//
//  Created by wei.chen on 15/2/5.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@class ThemeImageView;
@interface MainController : UITabBarController<SinaWeiboRequestDelegate> {
    ThemeImageView *_selectedImgView;
}

- (void)hideBadge;

@end
