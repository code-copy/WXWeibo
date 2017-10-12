//
//  MainTabbarController.m
//  WXMovie
//
//  Created by wei.chen on 15/2/5.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainController.h"
#import "WXNavigationController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@implementation MainController {
    NSMutableArray *_tabbarButtons;
    ThemeImageView *_bgView;
    ThemeImageView *_badgeImgView;   //显示未读数
}

- (void)hideBadge {
    _badgeImgView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabbarButtons = [NSMutableArray array];
    
    //1.创建选项工具栏
    [self _createTabbarView];
    
    //2.创建子控制器
    [self _createViewControllers];
    
    //3.请求未读消息数据
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

//1.创建选项工具栏
- (void)_createTabbarView {
    _bgView = [[ThemeImageView alloc] initWithFrame:self.tabBar.bounds];
    _bgView.imgName = @"mask_navbar.png";
    [self.tabBar addSubview:_bgView];
    
    NSArray *imgNames = @[
                          @"home_tab_icon_1.png",
                          @"home_tab_icon_2.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_5.png",
                          ];
    
    CGFloat itemWidth = kScreenWidth/imgNames.count;
    for (int i=0; i<imgNames.count; i++) {
        NSString *name = imgNames[i];
        
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(itemWidth*i, 0, itemWidth, 49);
        button.imgName = name;
        button.tag = i;
        [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        [_tabbarButtons addObject:button];
    }
    
    _selectedImgView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 49)];
    _selectedImgView.imgName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImgView];
    
    
    //创建未读数图标视图
    _badgeImgView = [[ThemeImageView alloc] initWithFrame:CGRectMake(itemWidth-32, 0, 32, 32)];
    _badgeImgView.hidden = YES;
    _badgeImgView.imgName = @"number_notify_9.png";
    [self.tabBar addSubview:_badgeImgView];
    
    ThemeLabel *badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImgView.bounds];
    badgeLabel.colorName = @"Timeline_Notice_color";
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.font = [UIFont boldSystemFontOfSize:13];
    badgeLabel.backgroundColor = [UIColor clearColor];
    badgeLabel.tag = 100;
    [_badgeImgView addSubview:badgeLabel];
    
}

//2.创建子控制器
- (void)_createViewControllers {
    
    //1.定义各个模块的故事版的名字
    NSArray *storyboardNames = @[@"Home",@"Message",@"Profile",@"Disconver",@"More"];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for(int i=0;i<storyboardNames.count;i++) {
        
        //2.取得故事版的文件名
        NSString *name = storyboardNames[i];
        
        //3.创建故事版加载对象
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
        
        //4.加载故事版，获取故事版中箭头指向的控制器对象
        WXNavigationController *navigation = [storyboard instantiateInitialViewController];
        
        [viewControllers addObject:navigation];
        
    }

    self.viewControllers = viewControllers;
}

- (void)timeAction {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appDelegate.sinaWeibo;
    
    [sinaweibo requestWithURL:@"remind/unread_count.json"
                       params:nil httpMethod:@"GET"
                     delegate:self];
    
}

- (void)selectTab:(UIButton *)button {
    
    NSInteger index = button.tag;
    
    //    [self setSelectedIndex:index];
    self.selectedIndex = index;
    
    [UIView animateWithDuration:0.2 animations:^{
        _selectedImgView.center = button.center;
    }];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //移除tabbar上的按钮
    
    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        
        Class cla = NSClassFromString(@"UITabBarButton");
        
        //判断view对象是否是UITabBarButton类型
        if ([view isKindOfClass:cla]) {
            [view removeFromSuperview];
        }
    }
    
//    NSArray *subViews = self.tabBar.subviews;
//    //让数组中的每一个对象都调用方法：removeFromSuperview
//    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //布局
    CGFloat itemWidth = kScreenWidth/_tabbarButtons.count;
    for (int i=0; i<_tabbarButtons.count; i++) {
        UIButton *button = _tabbarButtons[i];
        button.frame = CGRectMake(itemWidth*i, 0, itemWidth, 49);
        
    }
    _bgView.frame = self.tabBar.bounds;
    
    _selectedImgView.frame = CGRectMake(itemWidth*self.selectedIndex, 0, itemWidth, 49);
    
    _badgeImgView.frame = CGRectMake(itemWidth-32, 0, 32, 32);
}

#pragma mark - SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    //新微博的未读数
    NSNumber *status = result[@"status"];
    
    if ([status integerValue] > 0) {
        //显示未读数据
        _badgeImgView.hidden = NO;
        
        ThemeLabel *badgeLabel = (ThemeLabel *)[_badgeImgView viewWithTag:100];
        
        NSString *unRead = [status stringValue];
        
        if ([status integerValue] >= 100) {
            unRead = @"99+";
        }
        
        badgeLabel.text = unRead;
    }
    else {
        //隐藏
        _badgeImgView.hidden = YES;
    }
    
}



@end
