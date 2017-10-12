//
//  BaseController.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFHTTPRequestOperation;
@interface BaseController : UIViewController {
    
    UIWindow *_tipWindow;
    
}

//1.显示加载提示
- (void)showLoading:(BOOL)show;

//2.显示HUD提示
- (void)showHUD:(NSString *)title;

//隐藏HUD，如果有标题，隐藏之前，显示完成提示
- (void)hideHUD:(NSString *)title;

//3.状态栏提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation*)operation;

@end
