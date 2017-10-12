//
//  WXNavigationController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WXNavigationController.h"
#import "ThemeManager.h"

@interface WXNavigationController ()

@end

@implementation WXNavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotification object:nil];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self themeChangeAction];
}

- (void)themeChangeAction {
    
    //1.获取导航栏的图片
    UIImage *image = [[ThemeManager shareInstance] getThemeImage:@"mask_titlebar64.png"];
    
    //2.设置导航栏上面的图片
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //3.加载导航栏上标题的颜色
    UIColor *titleColor = [[ThemeManager shareInstance] getThemeColor:@"Mask_Title_color"];
    NSDictionary *textAttr = @{
                               NSForegroundColorAttributeName:titleColor
                            };
    self.navigationBar.titleTextAttributes = textAttr;
    
    
    //设置按钮的颜色
    self.navigationBar.tintColor = titleColor;
}

@end
