//
//  ViewController.m
//  JXTTwinkleStarView
//
//  Created by JXT on 2017/6/13.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "JXTTwinkleStarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //圆形
    JXTTwinkleStarView *starView = [JXTTwinkleStarView twinkleStarViewWithFrame:CGRectMake(0, 0, 200, 200) number:200 shape:JXTTwinkleStarViewShapeRound overflowRadius:50];
    starView.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5-150);
    starView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:starView];
    
    //方形
    JXTTwinkleStarView *starView2 = [JXTTwinkleStarView twinkleStarViewWithFrame:CGRectMake(0, 0, 200, 200) number:100 shape:JXTTwinkleStarViewShapeSquare overflowRadius:0];
    starView2.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5+150);
    starView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:starView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
