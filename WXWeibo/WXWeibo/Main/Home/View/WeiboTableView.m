//
//  WeiboTableView.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/7.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "DetailViewController.h"
#import "UIView+UIViewController.h"

@implementation WeiboTableView {
    
    NSString *_identinfy;
    WeiboCell *_propertyCell;
    
    NSMutableDictionary *_cellHeightCache;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        [self _loadView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self _loadView];
    }
    
    return self;
}

- (void)_loadView {
    
    //1.设置代理对象
    self.delegate = self;
    self.dataSource = self;
    
    //2.注册单元格
    _identinfy = @"WeiboCell-id";
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:_identinfy];
    
    _propertyCell = [[[NSBundle mainBundle]  loadNibNamed:@"WeiboCell" owner:nil options:nil] lastObject];
    
}


#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:_identinfy forIndexPath:indexPath];
    
    cell.weiboModel = _data[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiboModel *weiboModel = _data[indexPath.row];
    NSString *weiboID = [weiboModel.weiboId stringValue];
    
    if (_cellHeightCache == nil) {
        _cellHeightCache = [NSMutableDictionary dictionary];
    }
    
    NSNumber *heightNumber = _cellHeightCache[weiboID];
    if (heightNumber == nil) {
        _propertyCell.width = self.width;
        
        _propertyCell.weiboModel = weiboModel;
        
        [_propertyCell setNeedsLayout];
        [_propertyCell layoutIfNeeded];
        
        CGSize size = [_propertyCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        CGFloat height = size.height;
        
        //height 是contentView的高度，而cell的高度要比contentView多1个尺寸
        [_cellHeightCache setObject:@(height+1) forKey:weiboID];
        
        heightNumber = @(height+1);
    }
    
    return [heightNumber floatValue];
}

//选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"%@",[self viewController]);
    
    WeiboModel *weiboModel = self.data[indexPath.row];
    
    
    DetailViewController *detailVC = [self.viewController.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    detailVC.weiboModel = weiboModel;
    
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
    
    
    
}

@end
