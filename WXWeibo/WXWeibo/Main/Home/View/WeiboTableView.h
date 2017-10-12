//
//  WeiboTableView.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/7.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableView : UITableView<UITableViewDelegate,UITableViewDataSource>
{
    //1.子视图
    
}

//2.数据
@property(nonatomic,strong)NSArray *data;  //[微博Model,...]

@property(nonatomic,strong)NSMutableDictionary *cellHeightCache;

@end
