//
//  DetailViewController.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseController.h"

@class WeiboModel;
@class CommentTableView;
@interface DetailViewController : BaseController {
    
    NSMutableArray *_data;
    
}

@property(nonatomic,strong)WeiboModel *weiboModel;

@property (weak, nonatomic) IBOutlet CommentTableView *tableView;
@end
