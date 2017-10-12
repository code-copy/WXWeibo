//
//  MoreViewController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreCell.h"
#import "ThemeManager.h"
#import "ThemeViewController.h"
#import "UIViewController+MMDrawerController.h"


@interface MoreViewController ()

@end

@implementation MoreViewController {
    NSString *identify;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //注册单元格类型
    identify = @"MoreCell";
    [_tableView registerClass:[MoreCell class] forCellReuseIdentifier:identify];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
    
    //关闭左滑、右滑手势
//    self.navigationController
//    self.tabBarController
    
    //取得父控制器
//    NSLog(@"%@",self.mm_drawerController);
    
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.imgView.imgName = @"more_icon_theme.png";
            cell.txLabel.text = @"主题选择";
            cell.dtLabel.text = [ThemeManager shareInstance].themeName;
        }
        else if(indexPath.row == 1) {
            cell.imgView.imgName = @"more_icon_account.png";
            cell.txLabel.text = @"账户管理";
        }
    }
    else if(indexPath.section == 1) {
        cell.txLabel.text = @"意见反馈";
        cell.imgView.imgName = @"more_icon_feedback.png";
    }
    else if(indexPath.section == 2) {
        cell.txLabel.text = @"登出当前账号";
        cell.txLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    //设置箭头
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeViewController *themeVC = [[ThemeViewController alloc] init];
        [self.navigationController pushViewController:themeVC animated:YES];
    }
    
    //取消选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
