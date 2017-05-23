//
//  ViewController.m
//  AnimationBlockDelegateTest
//
//  Created by JXT on 2017/5/23.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "JXTAnimationBlockDelegate.h"

@interface ViewController () 
@property (nonatomic, strong) UIView * testView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    self.testView = testView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    moveAnimation.duration = 1.0;
    moveAnimation.delegate = [JXTAnimationBlockDelegate animationBlockDelegateWithAnimationDidStart:^{
        NSLog(@"start");
    } animationDidStop:^(BOOL finished) {
        NSLog(@"stop - %zd", finished);
    }];
    [self.testView.layer addAnimation:moveAnimation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
