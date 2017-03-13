//
//  ViewController.m
//  PassthroughView
//
//  Created by JXT on 2017/3/10.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "PassthroughView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *passthroughButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [passthroughButton setTitle:@"Passthrough" forState:UIControlStateNormal];
    [self.view addSubview:passthroughButton];
    passthroughButton.frame = CGRectMake(100, 100, 120, 40);
    passthroughButton.backgroundColor = [UIColor grayColor];
    passthroughButton.showsTouchWhenHighlighted = YES;
    [passthroughButton addTarget:self action:@selector(passthroughButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    passthroughButton.exclusiveTouch = YES;
    
    PassthroughView *coverView = [PassthroughView buttonWithType:UIButtonTypeCustom];
    coverView.frame = CGRectMake(0, 0, 200, 100);
    coverView.center = passthroughButton.center;
    coverView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.5];
    coverView.passthroughViews = [NSArray arrayWithObject:passthroughButton];
    coverView.showsTouchWhenHighlighted = YES;
    [coverView addTarget:self action:@selector(coverViewAction:) forControlEvents:UIControlEventTouchUpInside];
    coverView.exclusiveTouch = YES;
    [self.view addSubview:coverView];
    
    
    UIButton *passthroughButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [passthroughButton2 setTitle:@"Passthrough2" forState:UIControlStateNormal];
    [self.view addSubview:passthroughButton2];
    passthroughButton2.frame = CGRectMake(100, 300, 120, 40);
    passthroughButton2.backgroundColor = [UIColor redColor];
    passthroughButton2.showsTouchWhenHighlighted = YES;
    [passthroughButton2 addTarget:self action:@selector(passthroughButtonAction2:) forControlEvents:UIControlEventTouchUpInside];
    passthroughButton2.exclusiveTouch = YES;
    
    PassthroughView *coverView2 = [PassthroughView buttonWithType:UIButtonTypeCustom];
    coverView2.frame = CGRectMake(0, 0, 200, 100);
    coverView2.center = passthroughButton2.center;
    coverView2.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    coverView2.passthroughViews = [NSArray arrayWithObject:passthroughButton2];
    coverView2.showsTouchWhenHighlighted = YES;
    [coverView2 addTarget:self action:@selector(coverViewAction2:) forControlEvents:UIControlEventTouchUpInside];
    coverView2.exclusiveTouch = YES;
    [self.view addSubview:coverView2];
    
}

- (void)passthroughButtonAction:(id)aSender
{
    NSLog(@"点击passthroughButton");
}

- (void)coverViewAction:(id)aSender
{
    NSLog(@"点击coverView");
}

- (void)passthroughButtonAction2:(id)aSender
{
    NSLog(@"点击passthroughButton2");
}

- (void)coverViewAction2:(id)aSender
{
    NSLog(@"点击coverView2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
