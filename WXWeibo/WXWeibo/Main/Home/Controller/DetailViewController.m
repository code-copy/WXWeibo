//
//  DetailViewController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DetailViewController.h"
#import "MyDataService.h"
#import "WeiboModel.h"
#import "CommentModel.h"
#import "CommentTableView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博详情";
    _data = [[NSMutableArray alloc] init];
    
    self.tableView.hidden = YES;
    [super showLoading:@"正在加载..."];
    [self _loadCommentData];
}

//请求评论列表数据
- (void)_loadCommentData {
//    NSString *weiboID= [self.weiboModel.weiboId stringValue];
    NSString *weiboID= self.weiboModel.idstr;
    
    
    NSDictionary *params = @{@"id":weiboID};
    
    [MyDataService requestURL:@"comments/show.json" httpMethod:@"GET" params:params fileDatas:nil  completion:^(id result) {
       
        NSArray *comments = result[@"comments"];
        for (NSDictionary *commentJSON in comments) {
            
            CommentModel *cm = [[CommentModel alloc] initWithDataDic:commentJSON];
            
            [_data addObject:cm];
        }
        
        
        
        //刷新TableView，展示评论列表
        //数据_data  ---> View : UITableView
        self.tableView.commentDatas = _data;
        self.tableView.weiboModel = self.weiboModel;
        [self.tableView reloadData];
        
        self.tableView.hidden = NO;
        [super showLoading:nil];
        
    }];
    
}




@end
