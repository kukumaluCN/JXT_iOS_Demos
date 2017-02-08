//
//  CanvasViewController.m
//  Quartz2DDemo
//
//  Created by JXT on 2017/2/8.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "CanvasViewController.h"

#import "CanvasView.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.indexTitle;
    
    CanvasView *canvasView = [[CanvasView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    canvasView.index = self.index;
    [self.view addSubview:canvasView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
