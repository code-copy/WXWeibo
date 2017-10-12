//
//  WeiboCell.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/7.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"

#define kWeiboViewWidth (kScreenWidth-65)

@class WeiboModel;
@class WeiboView;
@class ThemeImageView;
@class ZoomingImgView;
@interface WeiboCell : UITableViewCell<WXLabelDelegate>

{
    //1.子视图
    __weak IBOutlet UIImageView *_userImage;
    __weak IBOutlet UILabel *_nickLabel;
    __weak IBOutlet UILabel *_commentLabel;
    __weak IBOutlet UILabel *_repostLabel;
    __weak IBOutlet UILabel *_sourceLabel;
    __weak IBOutlet UILabel *_createLabel;
    
    //2.微博内容视图
    
    __weak IBOutlet WXLabel *_weiboText;
    __weak IBOutlet WXLabel *_reWeiboText;
    __weak IBOutlet ZoomingImgView *_imgView;
    __weak IBOutlet ThemeImageView *_bgImgView;
    
    //约束
    __weak IBOutlet NSLayoutConstraint *_imgHeightConst;
    __weak IBOutlet NSLayoutConstraint *_imgTopConst;
    __weak IBOutlet NSLayoutConstraint *_reWeiboTopConst;
    
}

//数据
@property(nonatomic,strong)WeiboModel *weiboModel;

@end
