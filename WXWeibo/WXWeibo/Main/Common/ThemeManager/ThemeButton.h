//
//  ThemeButton.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/3.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

//normal 状态下显示的图片名
@property(nonatomic,copy)NSString *imgName;

//高亮状态下显示的图片名
@property(nonatomic,copy)NSString *highlightImgName;

@end
