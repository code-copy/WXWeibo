//
//  CommentTableView.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboModel;
@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *commentDatas;
@property(nonatomic,strong)WeiboModel *weiboModel;

@end
