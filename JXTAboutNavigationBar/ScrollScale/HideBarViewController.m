//
//  HideBarViewController.m
//  ScrollScale
//
//  Created by JXT on 16/3/18.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXT_iOS_Demos
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import "HideBarViewController.h"

@interface HideBarViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation HideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //  1.tableView
    [self.view addSubview:self.tableView];
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

#pragma mark - 滑动隐藏导航栏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;//注意
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
    
    if (offsetY > 64) {
        if (panTranslationY > 0) { //下滑趋势，显示
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        else {  //上滑趋势，隐藏
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
//    NSLog(@"%lf %lf", [scrollView.panGestureRecognizer translationInView:self.tableView].y, offsetY);
}

#pragma mark - 滑动隐藏导航栏2
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    NSLog(@"======== %lf", velocity.y);
//    
//    if(velocity.y > 0) {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//    }
//    else {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//    }
//}

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
