//
//  WeiboModel.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/7.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
#import "UIUitles.h"

@implementation WeiboModel

/*
- (NSDictionary *)attributeMapDictionary {
    
    //属性名 ：JSON字典的key
    NSDictionary *mapAtt = {
        //key : value
        @"createDate": @"created_at",
        
    };
    
}
*/

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    self.weiboId = dataDic[@"id"];
    
    //用户的数据
    NSDictionary *userJSON = dataDic[@"user"];
    self.user = [[UserModel alloc] initWithDataDic:userJSON];
    
    //原微博对象
    NSDictionary *retweeted_status = dataDic[@"retweeted_status"];
    if (retweeted_status != nil) {
        self.reWeibo = [[WeiboModel alloc] initWithDataDic:retweeted_status];
        
        //为原微博的内容开头加上作者的昵称
        NSString *nickName = self.reWeibo.user.screen_name;
        NSString *text = [NSString stringWithFormat:@"@%@：%@",nickName,self.reWeibo.text];
        
        self.reWeibo.text = text;
    }
    
    //2.处理微博来源字符串
    //<a href="http://app.weibo.com/t/feed/3auC5p" rel="nofollow">皮皮时光机</a>
    NSString *regex = @">.+<";
//    NSArray *items = [self.source componentsMatchedByRegex:regex];
//    
//    NSString *result = [items firstObject];
    
    NSRange range = [self.source rangeOfRegex:regex];
    if (range.location != NSNotFound) {
        range.location += 1; //去掉 >
        range.length -= 2;   //长度-2   去掉>  < 两个字符
        
        self.source = [self.source substringWithRange:range];
    }
    
    //3.处理表情图片
    
    //微博[哈哈]内容  ---> 微博<image url='png'>内容
    self.text = [UIUitles parseFaceImg:self.text];
}



@end
