//
//  ThemeButton.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/3.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNotification object:nil];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}


- (void)setImgName:(NSString *)imgName {
    
    if (_imgName != imgName) {
        _imgName = [imgName copy];
        
        UIImage *img = [[ThemeManager shareInstance] getThemeImage:_imgName];
        [self setImage:img forState:UIControlStateNormal];
        
    }
}

- (void)setHighlightImgName:(NSString *)highlightImgName {
    
    if (_highlightImgName != highlightImgName) {
        _highlightImgName = highlightImgName;
        
        UIImage *img = [[ThemeManager shareInstance] getThemeImage:_highlightImgName];
        [self setImage:img forState:UIControlStateHighlighted];
        
    }
    
}

- (void)themeChangeAction:(NSNotification *)notification {
    //收到切换主题的通知，重新加载新主题的图片
    if (_imgName) {
        UIImage *img = [[ThemeManager shareInstance] getThemeImage:_imgName];
        [self setImage:img forState:UIControlStateNormal];
    }
    
    if (_highlightImgName) {
        UIImage *img = [[ThemeManager shareInstance] getThemeImage:_highlightImgName];
        [self setImage:img forState:UIControlStateHighlighted];
    }
    
}

@end
