//
//  UIUitles.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/14.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UIUitles.h"
#import "RegexKitLite.h"

@implementation UIUitles

+ (NSString *)parseFaceImg:(NSString *)text {
    
    //1.查找 [哈哈]
    //2.查找表情名 ---> 图片名
    //3.把 [哈哈]  替换成 <image url = '图片名'>
    
    //1
    NSString *faceRegex = @"\\[\\w+\\]";
    NSArray *faceItems = [text componentsMatchedByRegex:faceRegex];
    
    //2
    //<1>读取emoticons.plist 表情配置文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
    NSArray *emoticons = [NSArray arrayWithContentsOfFile:filePath];
    
    //<2>循环、遍历所有找出来的表情名：[哈哈]、[呵呵]
    for (NSString *faceName in faceItems) {
        
        //<3>定义谓词条件，到emoticons.plist 中查找表情名对应的item
        
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        
        //<4>使用谓词去数组中查找过滤
        NSArray *results = [emoticons filteredArrayUsingPredicate:predicate];
        
        NSDictionary *faceDictionary = [results firstObject];
        
        //<5>取得图片名
        NSString *imgName = faceDictionary[@"png"];
        
        if (imgName.length == 0) {
            continue;
        }
        
        //<6>构造标签 <image url = '图片名'>
        NSString *element = [NSString stringWithFormat:@"<image url = '%@'>",imgName];
        
        //<7>将 [表情名] 替换成 标签：<image url = '图片名'>
        text = [text stringByReplacingOccurrencesOfString:faceName withString:element];
    }
    
    return text;
}

@end
