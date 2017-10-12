//
//  RightViewController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/13.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "SendViewController.h"
#import "WXNavigationController.h"

@interface RightViewController ()

@end

@implementation RightViewController {
    ThemeButton *sendButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    sendButton = [[ThemeButton alloc] initWithFrame:CGRectZero];
    sendButton.imgName = @"newbar_icon_1.png";
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    sendButton.frame = CGRectMake(self.view.width-50, 50, 40, 40);
}


- (void)sendAction:(ThemeButton *)button {
    
    SendViewController *sendVC = [[SendViewController alloc] init];
    WXNavigationController *navigaiton = [[WXNavigationController alloc] initWithRootViewController:sendVC];
    
    [self presentViewController:navigaiton animated:YES completion:NULL];
}


@end
