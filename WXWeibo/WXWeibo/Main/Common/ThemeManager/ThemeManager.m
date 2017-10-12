//
//  ThemeManager.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/3.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeManager.h"

#define kThemeName @"kThemeName"

@implementation ThemeManager

+ (instancetype)shareInstance {
    
    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        //2.读取本地保存的主题名称
        NSString *saveThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (saveThemeName.length > 0) {
            _themeName = saveThemeName;
        }
        
        //3.读取主题的配置文件theme.plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"theme.plist" ofType:nil];
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        
        //4.读取颜色的配置文件config.plist
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _fontColorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //1.设置默认的主题名
        _themeName = [[_themeConfig allKeys] firstObject];

    }
    return self;
}

//这个主题名称的set方法被调用，代表要切换主题了
- (void)setThemeName:(NSString *)themeName {
    
    if (_themeName != themeName) {
        _themeName = themeName;
        
        //1.保存当前选中的主题到本地
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //2.读取颜色的配置文件config.plist
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _fontColorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //3.发送主题切换的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
    }
    
}

- (UIImage *)getThemeImage:(NSString *)imageName {
    
    if (imageName.length == 0) {
        return nil;
    }
    
    //1.获取主题包的路径
    NSString *path = [self themePath];
    
    //2.将图片名与主题包路径拼接
    NSString *filePath = [path stringByAppendingPathComponent:imageName];
    
    //3.通过路径读取图片文件
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}

- (UIColor *)getThemeColor:(NSString *)colorName {
    if (colorName.length == 0) {
        return nil;
    }
    
    NSDictionary *rgbDic = [_fontColorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    
    CGFloat aValue = 0;
    NSNumber *alpha = rgbDic[@"alpha"];
    if (alpha == nil) {
        aValue = 1;
    } else {
        aValue = [alpha floatValue];
    }
    
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:aValue];
    
    return color;
}

//获取主题目录的路径
- (NSString *)themePath {
    
    //<1>取得程序包的根目录路径
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    
    //<2>取得当前主题包的子路径
    NSString *themeSubPath = [_themeConfig objectForKey:_themeName];
    
    //<3>主题包目录的路径
    NSString *path = [bundlePath stringByAppendingPathComponent:themeSubPath];
    
    return path;
}

@end
