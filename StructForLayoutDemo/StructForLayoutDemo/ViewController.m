//
//  ViewController.m
//  StructForLayoutDemo
//
//  Created by JXT on 2018/8/9.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "ViewController.h"

/**
 布局常量结构体
 */
typedef struct {
    CGFloat myViewLeftGap;
    CGFloat myViewTopGap;
    CGSize myViewSize;
} MyLayoutConsts;


@interface ViewController ()
@property (nonatomic, strong) UIView * myView;
@end

@implementation ViewController
{
    MyLayoutConsts _layout;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _layout = (MyLayoutConsts){
        .myViewLeftGap = 20,
        .myViewTopGap = 20,
        .myViewSize = CGSizeMake(100, 100)
    };
    [self.view addSubview:self.myView];
}


#pragma mark - UI
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.myView.frame = (CGRect){_layout.myViewLeftGap, _layout.myViewTopGap, _layout.myViewSize};
}


#pragma mark - Lazy Load
- (UIView *)myView
{
    if (!_myView) {
        _myView = [[UIView alloc] initWithFrame:CGRectZero];
        _myView.backgroundColor = [UIColor redColor];
    }
    return _myView;
}

@end
