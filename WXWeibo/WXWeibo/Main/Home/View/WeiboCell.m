//
//  WeiboCell.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/7.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "ThemeImageView.h"
#import "ThemeManager.h"
#import "ZoomingImgView.h"

@implementation WeiboCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if(self) {
        //_bgImgView.imgName = @"timeline_rt_border_9.png";
        
        //监听切换主题的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNotification object:nil];
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    _bgImgView.leftWidth = 25;
    _bgImgView.topHeight = 25;
    _bgImgView.imgName = @"timeline_rt_border_9.png";
    
    //设置WXLabel对象的代理
    _weiboText.wxLabelDelegate = self;
    _reWeiboText.wxLabelDelegate = self;
}

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    _weiboModel = weiboModel;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //填充数据
    
    //1.头像
    NSString *imgURL = self.weiboModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:imgURL]];
    
    //2.昵称
    _nickLabel.text = self.weiboModel.user.screen_name;
    
    //3.发布时间
    //Tue May 31 17:46:55 +0800 2011
    //E M d HH:mm:ss Z yyyy
    
    //NSDate --->  NSString
    // 04-07 17:46   //MM-dd HH:mm
    
    NSString *create_at = self.weiboModel.created_at;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E M d HH:mm:ss Z yyyy"];
    NSDate *date = [dateFormatter dateFromString:create_at];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *datestring = [dateFormatter stringFromDate:date];
    _createLabel.text = datestring;
    
    //4.来源
    _sourceLabel.text = self.weiboModel.source;
    
    
    //5.转发数
    _repostLabel.text = [NSString stringWithFormat:@"转发：%@",self.weiboModel.reposts_count];
    
    //6.评论数
    _commentLabel.text = [NSString stringWithFormat:@"评论：%@",self.weiboModel.comments_count];
    
    //7.微博视图
    WeiboModel *reWeibo = self.weiboModel.reWeibo;
    
    //(1)微博内容
    _weiboText.text = self.weiboModel.text;
    NSString *weiboImgURL = nil;
    NSString *weiboImgOrg = nil;
    
    //<1>无转发的微博
    if (reWeibo == nil) {
        //(2)微博图片的URL
        weiboImgURL = self.weiboModel.thumbnail_pic;
        weiboImgOrg = self.weiboModel.original_pic;
        
        //(3)隐藏原微博的Label
        _reWeiboText.text = nil;
        
        //(4)隐藏原微博的背景视图
        _bgImgView.hidden = YES;
        
        //原微博与微博内容的空隙
        _reWeiboTopConst.constant = 0;
    }else {
    //<2>有转发的微博
        
        //(2)微博图片的URL
        weiboImgURL = reWeibo.thumbnail_pic;
        weiboImgOrg = reWeibo.original_pic;
        
        //(3)显示原微博的Label
        _reWeiboText.text = reWeibo.text;
        
        //(4)显示原微博的背景
        _bgImgView.hidden = NO;
        
        //原微博与微博内容的空隙
        _reWeiboTopConst.constant = 10;
    }
    
    //判断是否显示微博图片
    if (weiboImgURL) {
        _imgHeightConst.constant = 80;
        _imgTopConst.constant = 10;
        
        _imgView.urlstring = weiboImgOrg;
        
        [_imgView setImageWithURL:[NSURL URLWithString:weiboImgURL]];
    } else {
        //隐藏图片
        _imgHeightConst.constant = 0;
        _imgTopConst.constant = 0;
    }
    
    _weiboText.numberOfLines = 0;
    _reWeiboText.numberOfLines = 0;
    _weiboText.preferredMaxLayoutWidth = CGRectGetWidth(_weiboText.bounds);
    _reWeiboText.preferredMaxLayoutWidth = CGRectGetWidth(_reWeiboText.bounds);
}

- (void)themeChangeAction:(NSNotification *)notification {
    
    //重新绘制文本
//    [_reWeiboText setNeedsDisplay];
//    [_weiboText setNeedsDisplay];
}

#pragma mark - WXLabel delegate
//1.返回需要添加超链接的正则表达式
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    
    //1.@用户
    NSString *regex1 = @"@[\\w]+";
    
    //2.http://连接   http(s)://www.baidu123.com/ssh/ov
    NSString *regex2 = @"http(s)?://([A-Za-z0-9.-_]+(/)?)+";
    
    //3.#话题#
    NSString *regex3 = @"#.+#";
    
    NSString *rgex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    
    return rgex;
}

//2.设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
//    return [UIColor blueColor];
    
//    NSLog(@"%@",[[ThemeManager shareInstance] getThemeColor:@"Link_color"]);
    
    return [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
}

//3.超链接被点击的高亮颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor darkGrayColor];
}

//4.超连接触摸结束后的事件
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {
    
    NSLog(@"%@",context);
    
}

@end
