//
//  BaseController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"
#import "MBProgressHUD.h"
#import "UIProgressView+AFNetworking.h"
#import "AFHTTPRequestOperation.h"

@interface BaseController ()

@end

@implementation BaseController {
    UIView *_tipView;
    MBProgressHUD *_hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//1.显示加载提示
- (void)showLoading:(BOOL)show {
    
    if (_tipView == nil) {
        
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.center.y, kScreenWidth, 30)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        //1.loading视图
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView startAnimating];
        [_tipView addSubview:activityView];
        
        //2.提示的Label
        UILabel *loadLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.font = [UIFont boldSystemFontOfSize:14];
        loadLabel.textColor = [UIColor blackColor];
        loadLabel.text = @"正在加载...";
        [loadLabel sizeToFit];
        [_tipView addSubview:loadLabel];
        
        loadLabel.left = (kScreenWidth-loadLabel.width)/2;
        activityView.right = loadLabel.left - 5;
    }
    
    if (show) {
        [self.view addSubview:_tipView];
    } else {
        if ([_tipView superview]) {
            [_tipView removeFromSuperview];
        }
    }
    
}

- (void)showHUD:(NSString *)title {
    
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    _hud.labelText = title;
//    _hud.detailsLabelText  //子标题
    
    //灰色的背景盖住父视图
//    _hud.dimBackground = YES;
    
    [_hud show:YES];
}

- (void)hideHUD:(NSString *)title {
    
    if (title.length == 0) {
        [_hud hide:YES];
    } else {
        
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        //显示模式设置为：自定义视图模式
        _hud.mode = MBProgressHUDModeCustomView;
        _hud.labelText = title;
        
        //延迟隐藏
        [_hud hide:YES afterDelay:1.5];
    }
    
}

//3.状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation*)operation
 {
    
    if (_tipWindow == nil) {
        //创建window用于盖在状态栏上
        _tipWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //创建Label
        UILabel *tpLabel = [[UILabel alloc] initWithFrame:_tipWindow.bounds];
        tpLabel.textAlignment = NSTextAlignmentCenter;
        tpLabel.backgroundColor = [UIColor clearColor];
        tpLabel.font = [UIFont systemFontOfSize:13];
        tpLabel.textColor = [UIColor whiteColor];
        tpLabel.tag = 2015;
        [_tipWindow addSubview:tpLabel];
        
        //进度视图
        UIProgressView *progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progress.frame = CGRectMake(0, 20-3, kScreenWidth, 5);
        progress.tag = 2016;
        progress.progress = 0;
        [_tipWindow addSubview:progress];
    }
    
    UILabel *tpLabel = (UILabel *)[_tipWindow viewWithTag:2015];
    tpLabel.text = title;
    
    UIProgressView *progress = (UIProgressView *)[_tipWindow viewWithTag:2016];
    [progress setProgressWithUploadProgressOfOperation:operation animated:YES];
    
    
    if (show) {
//        [_tipWindow makeKeyAndVisible];
        _tipWindow.hidden = NO;
    } else {
        
        progress.hidden = YES;
        
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:2];
    }
    
}

- (void)removeTipWindow {
    
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
    
}

@end
