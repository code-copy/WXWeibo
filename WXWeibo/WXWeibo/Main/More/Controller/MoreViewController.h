//
//  MoreViewController.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"

@interface MoreViewController : BaseController<UITableViewDataSource,UITableViewDelegate> {
    
    __weak IBOutlet UITableView *_tableView;
    
}

@end
