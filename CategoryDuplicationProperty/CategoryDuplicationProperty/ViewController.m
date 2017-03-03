//
//  ViewController.m
//  CategoryDuplicationProperty
//
//  Created by JXT on 2017/3/3.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    
    NSLog(@"%@", self.view.class);
    NSLog(@"%zd", self.view.frame);
//    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", self.view.class);
//    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    NSLog(@"%zd", self.title);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
