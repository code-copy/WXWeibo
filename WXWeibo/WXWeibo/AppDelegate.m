//
//  AppDelegate.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey
                                         appSecret:kAppSecret
                                    appRedirectURI:kAppRedirectURI
                                       andDelegate:self];
    
    //取出本地保存的认证信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }

    
    MainController *mainVC = [[MainController alloc] init];
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    RightViewController *rightVC = [[RightViewController alloc] init];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:mainVC leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
    
    //1.设置右边控制器的显示宽度
    [drawerController setMaximumRightDrawerWidth:200.0];
    //2.设置左边控制器的显示宽度
    [drawerController setMaximumLeftDrawerWidth:100.0];
    
    //3.设置打开、关闭手势的有效范围区域
    //MMOpenDrawerGestureModeNone : 关闭手势
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //4.设置滑动的动画
    //<1>设置左边滑动动画
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSlide];
    
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
     
    self.window.rootViewController = drawerController;
    //self.window.rootViewController = mainVC;
    
    return YES;
}

#pragma mark - SinaWeibo delegate
//1.授权成功之后调用的协议方法
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo {
    
    //保存认证的信息
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//2.注销调用
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo {
    
    //移除本地保存的认证信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

//3.认证失败调用的协议方法
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error {
    
    NSLog(@"认证失败：%@",error);
    
}

@end
