//
//  CommentCell.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"


@class CommentModel;
@class WXLabel;
@interface CommentCell : UITableViewCell<WXLabelDelegate> {
    
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_nickLabel;
    __weak IBOutlet WXLabel *_commentLabel;
}

@property(nonatomic,strong)CommentModel *cm;

@end
