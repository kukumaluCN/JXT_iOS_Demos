//
//  ViewController.m
//  DelegateOptimizeTest
//
//  Created by JXT on 2017/1/12.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "ViewController2.h"

@interface ViewController () <VC2DataSourceDelegate>

@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(nextPage)];
    
    //检测是否遵循协议
    NSLog(@"%d", [self conformsToProtocol:@protocol(VC2DataSourceDelegate)]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Methods
- (void)nextPage
{
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    vc2.delegate = self;
    [self.navigationController pushViewController:vc2 animated:YES];
}


#pragma mark - VC2DataSourceDelegate
- (void)carryVC2Title:(NSString *)title fetcher:(ViewController2 *)vc2
{
    NSLog(@"title:%@", title);
    NSLog(@"%@", vc2);
}

- (void)carryVC2Message:(NSString *)message
{
    NSLog(@"message:%@", message);
}

- (void)receivedNetWorkDataDict:(NSDictionary *)dict
{
    NSLog(@"%@", dict);
}

@end
