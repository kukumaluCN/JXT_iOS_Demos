//
//  JXTScaleViewController.m
//  ScrollScale
//
//  Created by JXT on 16/3/11.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXT_iOS_Demos
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "JXTScaleViewController.h"

#import "JXTTransparentBarVC.h"
#import "HideBarViewController.h"

@interface JXTScaleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIImageView * topImageView;

@property (nonatomic, assign) CGFloat receiveAlpha;

@end

@implementation JXTScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"head"] forBarMetrics:UIBarMetricsCompact];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //  1.头像视图
    [self createScaleHeadView];
    
    //  2.tableView
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(goTransparentPage:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"navBar隐藏" style:UIBarButtonItemStyleDone target:self action:@selector(goHidePage:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

- (void)goTransparentPage:(UIBarButtonItem *)btn
{
    JXTTransparentBarVC * transBarVC = [[JXTTransparentBarVC alloc] init];
    transBarVC.alphaBlock = ^(CGFloat alpha){
        _receiveAlpha = alpha;
    };    
    [self.navigationController pushViewController:transBarVC animated:YES];
}
- (void)goHidePage:(UIBarButtonItem *)btn
{
    HideBarViewController * hideBarVC = [[HideBarViewController alloc] init];
    [self.navigationController pushViewController:hideBarVC animated:YES];
}

#pragma mark - 创建缩放头像视图
- (void)createScaleHeadView
{
    UIView * topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 44)];
    topBkView.backgroundColor = [UIColor clearColor];
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 78, 78)];
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width / 2.;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _topImageView.image = [UIImage imageNamed:@"head"];
    [topBkView addSubview:_topImageView];
    
    self.navigationItem.titleView = topBkView;
}

#pragma mark - 创建tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#pragma mark - 设置分割线顶头
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"CELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [self randomColor];
    
    return cell;
}

#pragma mark - 滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;//注意
    
    /**
     *  1 - offsetY/num1 = 0.45;
        0.45 为最终缩小倍率
        offsetY 为纵偏移量
        num1=300 为要计算的值
        150/165  就是滑动多少距离后，完成缩放
     */
    
    if (offsetY < 0 && offsetY >= -150) {
        _topImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-300), 1 + offsetY/(-300));
//        _topImageView.layer.anchorPoint = CGPointMake(0.5, offsetY/600. + 0.5);
//        NSLog(@"%lf - %lf", offsetY, 1 + offsetY/(-300));
    }
    else if (offsetY >= 0 && offsetY <= 165) {
        _topImageView.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300);
//        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5 + offsetY/600.);
    }
    else if (offsetY > 165) {
        _topImageView.transform = CGAffineTransformMakeScale(0.45, 0.45);
//        _topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    else if (offsetY < -150) {
        _topImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
//        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    
    CGRect frame = _topImageView.frame;
    frame.origin.y = 5;
    _topImageView.frame = frame;
}


- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
