//
//  ThemeViewController.m
//  WXWeibo
//
//  Created by wei.chen on 13-10-5.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeManager.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"主题选择";
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor = [UIColor clearColor];
//    self.tableView.backgroundView = nil;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    

    NSDictionary *themeDic = [ThemeManager shareInstance].themeConfig;
    _themeData = [themeDic allKeys];
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _themeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"kIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    NSString *themeName = [_themeData objectAtIndex:indexPath.row];
    cell.textLabel.text = themeName;
    
    //当前显示的主题
    NSString *currentThemeName = [ThemeManager shareInstance].themeName;
    if ([themeName isEqualToString:currentThemeName]) {
        //单元格中显示的主题打钩
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.获取到当前主题
    NSString *themeName = [_themeData objectAtIndex:indexPath.row];
    
    //2.修改当前主题
    [ThemeManager shareInstance].themeName = themeName;
    
    //3.刷新列表
    [tableView reloadData];
}

@end
