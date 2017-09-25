//
//  ViewController.m
//  IfNilTest
//
//  Created by JXT on 2017/9/25.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *array = nil;
    
    //http://www.cocoachina.com/ios/20141119/10247.html
    
    //下面这个判断条件是有歧义的
    if (array.count == 0) {
        NSLog(@"array.count == 0");
    }
    
    //这个才是包含了所有的条件
    if (array) {
        if (array.count == 0) {
            NSLog(@"array.count == 0");
        }
        else {
            NSLog(@"array.count != 0");
        }
    }
    else {
        NSLog(@"array == nil");
    }
    
    NSLog(@"%p", 0);
    NSLog(@"%p", (void *)0);
    NSLog(@"%p", nil);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
