//
//  ViewController.m
//  AddSubviewToLayout
//
//  Created by JXT on 2017/3/9.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "View1.h"
#import "View2.h"
#import "View3.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    View1 *v1 = [[View1 alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    v1.backgroundColor = [UIColor redColor];
    v1.tag = 100;
//    [self.view addSubview:v1];
    
    View2 *v2 = [[View2 alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    v2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    v2.tag = 200;
    [v1 addSubview:v2];
    
    View3 *v3 = [[View3 alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    v3.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    v3.tag = 300;
    [v2 addSubview:v3];
    
    //addSubview会触发layoutSubviews
    //但是真正开始触发的是从显示层开始的，逐层往下
    [self.view addSubview:v1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
