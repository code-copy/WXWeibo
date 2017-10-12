//
//  CommentTableView.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CommentTableView.h"
#import "CommentCell.h"
#import "WeiboCell.h"

@implementation CommentTableView {
    
    CommentCell *_proerptyCell;
    NSString *identify;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        identify = @"CommentCell";
        _proerptyCell = [self dequeueReusableCellWithIdentifier:identify];
    }
    return self;
}

#pragma mark - UITableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return self.commentDatas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.创建微博单元格cell
    if (indexPath.section == 0) {
        
        WeiboCell *weiboCell = [[[NSBundle mainBundle] loadNibNamed:@"WeiboCell" owner:nil options:nil] lastObject];
        weiboCell.weiboModel = self.weiboModel;
        
        return weiboCell;
    }
    
    //2.创建评论单元格cell
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    cell.cm = self.commentDatas[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1.计算微博单元格的高度
    if (indexPath.section == 0) {
        
        WeiboCell *weiboCell = [[[NSBundle mainBundle] loadNibNamed:@"WeiboCell" owner:nil options:nil] lastObject];
        
        weiboCell.width = self.width;
        weiboCell.weiboModel = self.weiboModel;
        
        [weiboCell setNeedsLayout];
        [weiboCell layoutIfNeeded];
        
        CGSize size = [weiboCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height+1;
    }
    
    //2.计算评论单元格的高度
    _proerptyCell.cm = self.commentDatas[indexPath.row];
    _proerptyCell.width = self.width;
    
    [_proerptyCell setNeedsLayout];
    [_proerptyCell layoutIfNeeded];
    
    CGSize size = [_proerptyCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1;
}

@end
