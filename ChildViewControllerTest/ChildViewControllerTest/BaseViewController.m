//
//  BaseViewController.m
//  ChildViewControllerTest
//
//  Created by JXT on 2017/2/13.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.frame = CGRectMake(arc4random_uniform(200)+50, arc4random_uniform(300)+50, 100, 50);
    [testButton setTitle:@"button" forState:UIControlStateNormal];
    testButton.backgroundColor = [UIColor orangeColor];
    [testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.testButton = testButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testButtonAction:(UIButton *)aSender
{
    NSLog(@"%@", self);
    
    if(aSender.tag == 1001)
    {
        NSLog(@"VC1");
    }
    else if(aSender.tag == 1002)
    {
        NSLog(@"VC2");
    }
    else if(aSender.tag == 1003)
    {
        NSLog(@"VC3");
    }
}

@end
