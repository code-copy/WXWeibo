//
//  WXWeiboTests.m
//  WXWeiboTests
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MyDataService.h"

/*
 单元测试的作用：
 1、可以测试某一部分的功能是否正确
 2、可以保留一些测试记录，方便以后查看
 3、可以作为功能的演示DEMO
 */

@interface WXWeiboTests : XCTestCase

@end

@implementation WXWeiboTests

//1.每个单元测试方法调用之前都会调用setUp
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

//2.每个单元测试方法调用之后都会调用tearDown
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//3.单元测试方法，必须以test方法名开头
- (void)testExample {
    // This is an example of a functional test case.
    //XCTAssert(YES, @"Pass");
    
    NSLog(@"----------------");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

//1.测试网络请求
//2.测试数据库是否可以存储
//3.测试A

- (void)testNetWorking {
    
    NSDictionary *parms = @{@"count":@"5"};
    
    [MyDataService requestURL:@"statuses/home_timeline.json" httpMethod:@"GET" params:parms fileDatas:nil completion:^(id result) {
       
        NSLog(@"result = %@",result);
        
    }];
    
    [[NSRunLoop currentRunLoop] run];
}

@end
