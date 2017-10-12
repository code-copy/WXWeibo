//
//  CommentCell.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"

@implementation CommentCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSString *userImgURL = self.cm.user.profile_image_url;
    [_imgView setImageWithURL:[NSURL URLWithString:userImgURL]];
    
    _nickLabel.text = self.cm.user.screen_name;
    
    _commentLabel.text = self.cm.text;
    _commentLabel.wxLabelDelegate = self;
    
    _commentLabel.preferredMaxLayoutWidth = CGRectGetWidth(_commentLabel.bounds);
}

#pragma mark - WXLabel delegate
//1.返回需要添加超链接的正则表达式
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    
    //1.@用户
    NSString *regex1 = @"@[\\w-]+";
    
    //2.http://连接   http(s)://www.baidu123.com/ssh/ov
    NSString *regex2 = @"http(s)?://([A-Za-z0-9.-_]+(/)?)+";
    
    //3.#话题#
    NSString *regex3 = @"#.+#";
    
    NSString *rgex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    
    return rgex;
}

//2.设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
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
