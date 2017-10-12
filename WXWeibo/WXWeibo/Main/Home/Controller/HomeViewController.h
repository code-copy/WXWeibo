//
//  HomeViewController.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"

@class WeiboTableView;
@interface HomeViewController : BaseController

@property(nonatomic,strong)NSMutableArray *data;

@property (weak, nonatomic) IBOutlet WeiboTableView *tableView;

- (IBAction)logoutAction:(id)sender;
- (IBAction)loginAction:(id)sender;

@end
