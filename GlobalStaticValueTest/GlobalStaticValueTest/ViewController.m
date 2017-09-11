//
//  ViewController.m
//  GlobalStaticValueTest
//
//  Created by JXT on 2017/9/8.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@", self);
    
    NSLog(@"globalIntValue - %zd - %p", globalIntValue, &globalIntValue);
    globalIntValue = 2;
    NSLog(@"globalIntValue - %zd - %p", globalIntValue, &globalIntValue);

    NSLog(@"globalIntValueStatic - %zd - %p", globalIntValueStatic, &globalIntValueStatic);
    globalIntValueStatic = 3;
    NSLog(@"globalIntValueStatic - %zd - %p", globalIntValueStatic, &globalIntValueStatic);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[NSClassFromString(@"ViewController2") new] animated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
