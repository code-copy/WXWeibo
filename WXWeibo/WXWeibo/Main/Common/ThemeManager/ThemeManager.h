//
//  ThemeManager.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/3.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

//主题切换的通知名
#define kThemeDidChangeNotification @"kThemeDidChangeNotification"


@interface ThemeManager : NSObject {
    
    NSDictionary *_themeConfig;
    NSDictionary *_fontColorConfig;
}

+ (instancetype)shareInstance;

//当前使用的主题名称
@property(nonatomic,copy)NSString *themeName;
@property(nonatomic,strong)NSDictionary *themeConfig;


/*
 * 方法说明：获取当前主题包下对应的图片数据
 * 参数说明：imageName  图片名
 * 返回值：图名在当前主题下对应的图片数据
 */
- (UIImage *)getThemeImage:(NSString *)imageName;

/*
 * 方法说明：获取当前主题包下对应的颜色
 * 参数说明：colorName  颜色名称
 * 返回值：当前主题对应的颜色
 */
- (UIColor *)getThemeColor:(NSString *)colorName;


@end
