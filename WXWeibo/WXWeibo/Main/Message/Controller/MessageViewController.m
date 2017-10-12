//
//  MessageViewController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

//单元测试

#import "MessageViewController.h"
#import "WXLabel.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXLabel *label = [[WXLabel alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
//    label.text = @"无限互联3G学院[哈哈]";
    label.text = @"无限互联3G学院<image url = '001.png'>";
    [self.view addSubview:label];
    
}


@end
