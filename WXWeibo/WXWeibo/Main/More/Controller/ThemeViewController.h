//
//  ThemeViewController.h
//  WXWeibo
//
//  Created by wei.chen on 13-10-5.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"

@interface ThemeViewController : BaseController<UITableViewDataSource,UITableViewDelegate> {
    NSArray *_themeData;
}

@property (retain, nonatomic) UITableView *tableView;
@end
