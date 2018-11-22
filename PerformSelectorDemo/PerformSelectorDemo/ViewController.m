//
//  ViewController.m
//  PerformSelectorDemo
//
//  Created by JXT on 2018/11/22.
//  Copyright © 2018 JXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)test
{
    NSLog(@"3");
    return @"";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //因为[self performSelector:@selector(test) withObject:nil afterDelay:.0];实际在runloop里面，是一个定时器，但你在子线程，默认没有开启runloop啊
        [self performSelector:@selector(test) withObject:nil afterDelay:0];
        [self performSelector:@selector(test) withObject:nil];
        [self performSelectorOnMainThread:@selector(test) withObject:nil waitUntilDone:YES];
        
        [self performSelector:NSSelectorFromString(@"test") withObject:nil afterDelay:0];
        [self performSelector:NSSelectorFromString(@"test") withObject:nil];
        [self performSelectorOnMainThread:NSSelectorFromString(@"test") withObject:nil waitUntilDone:YES];
        
        NSLog(@"2");
    });
}


@end
