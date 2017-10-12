//
//  MyDataService.h
//  WXWeibo
//
//  Created by wei.chen on 15/4/13.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@interface MyDataService : NSObject

+ (AFHTTPRequestOperation *)requestURL:(NSString *)urlstring
        httpMethod:(NSString *)method
            params:(NSDictionary *)params
         fileDatas:(NSDictionary *)fileDatas
        completion:(void(^)(id result))block;

@end
