//
//  HomeViewController.m
//  WXWeibo
//
//  Created by wei.chen on 15/4/2.
//  Copyright (c) 2015年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MainController.h"
#import "UIViewController+MMDrawerController.h"

@interface HomeViewController ()<SinaWeiboRequestDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [NSMutableArray array];
    
    //1.添加下拉刷新的控件
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//       
//        NSLog(@"下拉刷新...");
//        
//    }];
//    //开始下拉刷新
//    [self.tableView.header beginRefreshing];
//    self.tableView.header.backgroundColor = [UIColor orangeColor];
    
//    __weak HomeViewController *weakSelf = self;
    __weak typeof(self) weakSelf = self;
    
    //2.下拉刷新 播放Gif动画
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        [weakSelf _loadNewWeibo];
    }];
    
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i=0; i<6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i+1];
        UIImage *img = [UIImage imageNamed:imgName];
        [imgs addObject:img];
    }
    
    //设置闲置状态显示的图片
    NSArray *firstImg = [imgs subarrayWithRange:NSMakeRange(0, 1)];
    [self.tableView.gifHeader setImages:firstImg forState:MJRefreshHeaderStateIdle];
    
    //设置正在刷新播放的图片
    [self.tableView.gifHeader setImages:imgs forState:MJRefreshHeaderStateRefreshing];
    
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    //判断是否授权
    if (!sinaweibo.isAuthValid) {
        //没有授权则登陆
        [sinaweibo logIn];
    } else {
        //开始下拉刷新
        //[self.tableView.gifHeader beginRefreshing];
        
        self.tableView.hidden = YES;
        [super showHUD:@"正在加载..."];
        [self _loadNewWeibo];
        
    }
    
    //3.上拉刷新，加载下一页
    [self.tableView addLegendFooterWithRefreshingBlock:^{
       
        //NSLog(@"上拉...");
        [weakSelf _loadMoreWeiData];
        
    }];
    
}

//1.加载新微博数据
- (void)_loadNewWeibo {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"25" forKey:@"count"];
    
    //1.取得第一条微博ID，用于加载未读微博数据
    WeiboModel *topWeibo = [self.data firstObject];
    NSString *weiboID = [topWeibo.weiboId stringValue];
    if (weiboID.length != 0) {
        /**
         *  since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
         */
        [params setObject:weiboID forKey:@"since_id"];
    }
    
    SinaWeiboRequest *request = [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                       params:params
                   httpMethod:@"GET"
                     delegate:self];
    request.tag = 100;
    
}

- (void)_loadMoreWeiData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"25" forKey:@"count"];
    
    WeiboModel *lastWeibo = [self.data lastObject];
    if (lastWeibo == nil) {
        return;
    }
    
    /*
     max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     */
    NSString *lastID = [lastWeibo.weiboId stringValue];
    [params setObject:lastID forKey:@"max_id"];
    
    
    SinaWeiboRequest *request = [self.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                            params:params
                        httpMethod:@"GET"
                          delegate:self];
    request.tag = 200;
}

- (IBAction)logoutAction:(id)sender {
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    [sinaweibo logOut];
    
}

- (IBAction)loginAction:(id)sender {
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    [sinaweibo logIn];
}

- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaWeibo;
}

//显示加载新微博的数量
- (void)_showNewWeiboCount:(NSInteger)count {
    
    //1.创建视图
    ThemeImageView *bageImg = (ThemeImageView *)[self.view viewWithTag:100];
    if (bageImg == nil) {
        bageImg = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        bageImg.imgName = @"timeline_notify.png";
        bageImg.tag = 100;
        [self.view addSubview:bageImg];
        
        ThemeLabel *bageLabel = [[ThemeLabel alloc] initWithFrame:bageImg.bounds];
        bageLabel.backgroundColor = [UIColor clearColor];
        bageLabel.textAlignment = NSTextAlignmentCenter;
        bageLabel.colorName = @"Timeline_Notice_color";
        bageLabel.tag = 200;
        [bageImg addSubview:bageLabel];
    }
    
    //2.显示数据
    ThemeLabel *bageLabel = (ThemeLabel *)[bageImg viewWithTag:200];
    NSString *bageText = nil;
    if (count > 0) {
        bageText = [NSString stringWithFormat:@"%ld条新微博",count];
    } else {
        bageText = @"没有新微博数据";
    }
    bageLabel.text = bageText;
    
    //3.显示动画
    [UIView animateWithDuration:0.6 animations:^{
     
        //动画1：向下移动
        bageImg.transform = CGAffineTransformMakeTranslation(0, 40+64+5);
        
    } completion:^(BOOL finished) {
        
        //动画2：向下移动
        [UIView animateWithDuration:0.6 animations:^{
            
            //设置延迟执行的动画时间
            [UIView setAnimationDelay:1];
            
            bageImg.transform = CGAffineTransformIdentity;
            
        }];
        
    }];
    
    
    //4.播放提示声音
    if (count > 0) {
    
        NSString *filepath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:filepath];
        
        //1.将声音文件注册成系统声音
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        
        //2.播放系统声音
        AudioServicesPlaySystemSound(soundID);
    }
}

//当前控制器视图不显示
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //关闭
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}

//当前控制器视图即将显示
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //打开
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
}

#pragma mark - SinaWeiboRequest delegate
//1.数据请求完成之后
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    NSArray *statuses = [result objectForKey:@"statuses"];
    
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statuses.count];
    
    for (NSDictionary *weiboJSON in statuses) {
        
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:weiboJSON];
        
        [weibos addObject:weibo];
    }
    
    if (request.tag == 100) {  //1.下拉刷新的数据
//        [self showLoading:NO];
        
        [self hideHUD:@"加载完成"];
//        [self hideHUD:nil];
        self.tableView.hidden = NO;
        
//        NSLog(@"下拉加载...");
        
        [weibos addObjectsFromArray:self.data];
        self.data = weibos;
        
        //将weibos数组数据交给UITableView展示数据
        self.tableView.data = self.data;
        [self.tableView reloadData];
        
        //结束下拉刷新
        [self.tableView.header endRefreshing];
        
        //显示加载新微博数量的提示
        [self _showNewWeiboCount:statuses.count];
        
        //隐藏未读数图标
        //    [对象 功能];
        //[self.tabBarController 隐藏未读图片]
        
        MainController *mainCtrl = (MainController *)self.tabBarController;
        [mainCtrl hideBadge];
        
    } else if(request.tag == 200){  //2.上拉刷新的数据
        if (weibos.count > 0) {
            [weibos removeObjectAtIndex:0];
        }
        
        [self.data addObjectsFromArray:weibos];
        self.tableView.data = self.data;
        [self.tableView reloadData];
        
        //停止上拉刷新
        [self.tableView.footer endRefreshing];
        if (weibos.count == 0) {
            //没有更多数据，隐藏上拉视图
            self.tableView.footer.hidden = YES;
        }
    }
}

//2.数据请求失败
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"加载网络失败：%@",error);
}


//屏幕旋转后调用
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self.tableView.cellHeightCache removeAllObjects];
    
}

@end
