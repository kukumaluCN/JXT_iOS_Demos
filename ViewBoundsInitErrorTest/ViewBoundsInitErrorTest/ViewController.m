//
//  ViewController.m
//  ViewBoundsInitErrorTest
//
//  Created by JXT on 2017/9/15.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView * testView;
@property (nonatomic, strong) UIView * subView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化一个view，宽高不确定，可能由于动态计算，结果未负值，等重新布局后恢复
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, -20, -20)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    self.testView = testView;
    
    //一个testView的子视图，初始化尺寸为0，动态布局后恢复
    UIView *subView = [[UIView alloc] initWithFrame:CGRectZero];
    subView.backgroundColor = [UIColor blueColor];
    [testView addSubview:subView];
    self.subView = subView;
    
    //初始化尺寸为负值，实际尺寸为绝对值，坐标为负值，所以在屏幕外，不显示，但其bounds已经改变
    //testView - init - {{-20, -20}, {20, 20}}
    NSLog(@"testView - init - %@", NSStringFromCGRect(testView.frame));
    //testView - init - {{-20, -20}, {20, 20}}
    NSLog(@"testView - init - %@", NSStringFromCGRect(testView.bounds));
    
    //subView - init - {{-20, -20}, {20, 20}}
    NSLog(@"subView - init - %@", NSStringFromCGRect(subView.frame));
    //subView - init - {{-20, -20}, {20, 20}}
    NSLog(@"subView - init - %@", NSStringFromCGRect(subView.bounds));
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    //重新布局，testView显示正常，只是bounds改变，自身没影响，会影响子视图，因为坐标原点已经改变
    self.testView.frame = CGRectMake(100, 100, 100, 100);
    //这样写就恢复正常了
//    self.testView.bounds = CGRectMake(0, 0, 100, 100);
//    self.testView.center = CGPointMake(150, 150);
    //子视图本应该在父视图左上角，但因为父视图坐标原点改变，所以子视图位置改变，如果
    self.subView.frame = CGRectMake(0, 0, 20, 20); //CGRectMake(0, 0, -20, -20) == CGRectMake(-20, -20, 20, 20)
    
    NSLog(@"testView - layout - %@", NSStringFromCGRect(self.testView.frame));
    NSLog(@"testView - layout - %@", NSStringFromCGRect(self.testView.bounds));
    NSLog(@"subView - layout - %@", NSStringFromCGRect(self.subView.frame));
    NSLog(@"subView - layout - %@", NSStringFromCGRect(self.subView.bounds));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
