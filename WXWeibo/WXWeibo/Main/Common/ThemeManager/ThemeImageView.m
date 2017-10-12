//
//  ThemeImageView.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/3.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

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
        
        self.image = [[ThemeManager shareInstance] getThemeImage:_imgName];
    }
}

- (void)themeChangeAction:(NSNotification *)notification {
    if (_imgName) {
        self.image = [[ThemeManager shareInstance] getThemeImage:_imgName];        
    }
}

- (void)setImage:(UIImage *)image {
    image = [image stretchableImageWithLeftCapWidth:self.leftWidth topCapHeight:self.topHeight];
    
//    [super setImage:image];
    super.image = image;
}

@end
