//
//  MoreCell.h
//  WXWeibo
//
//  Created by wei.chen on 14-9-17.
//  Copyright (c) 2014年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLabel.h"

/**
 *  UILabel
 *  UIImageView
 */

@interface MoreCell : UITableViewCell

@property(nonatomic,strong)ThemeImageView *imgView;
@property(nonatomic,strong)ThemeLabel *txLabel;
@property(nonatomic,strong)ThemeLabel *dtLabel;

@end
