//
//  ViewController2.m
//  GlobalStaticValueTest
//
//  Created by JXT on 2017/9/8.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSLog(@"%@", self);
    
    NSLog(@"globalIntValue - %zd - %p", globalIntValue, &globalIntValue);
    globalIntValue = 200;
    NSLog(@"globalIntValue - %zd - %p", globalIntValue, &globalIntValue);
    
    NSLog(@"globalIntValueStatic - %zd - %p", globalIntValueStatic, &globalIntValueStatic);
    globalIntValueStatic = 300;
    NSLog(@"globalIntValueStatic - %zd - %p", globalIntValueStatic, &globalIntValueStatic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
