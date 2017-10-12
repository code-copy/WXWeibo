//
//  ThemeLabel.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/3.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotification object:nil];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

- (void)setColorName:(NSString *)colorName {
    
    if (_colorName != colorName) {
        _colorName = [colorName copy];
        
        UIColor *textColor = [[ThemeManager shareInstance] getThemeColor:_colorName];
        self.textColor = textColor;
    }
    
}

- (void)themeChangeAction {
    
    UIColor *textColor = [[ThemeManager shareInstance] getThemeColor:_colorName];
    self.textColor = textColor;
    
}

@end
