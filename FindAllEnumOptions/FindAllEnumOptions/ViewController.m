//
//  ViewController.m
//  FindAllEnumOptions
//
//  Created by JXT on 2018/7/9.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "ViewController.h"

typedef NS_OPTIONS(NSUInteger, MyOptions) {
    MyOptions_0 = 1 << 0,
    MyOptions_1 = 1 << 1,
    MyOptions_2 = 1 << 2,
    MyOptions_3 = 1 << 3,
    MyOptions_4 = 1 << 4,
    MyOptions_5 = 1 << 5,
    MyOptions_6 = 1 << 6,
    MyOptions_7 = 1 << 7,
    MyOptions_8 = 1 << 8,
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  All
     */
    NSLog(@"MyOptions_0 = %zd", MyOptions_0);
    NSLog(@"MyOptions_1 = %zd", MyOptions_1);
    NSLog(@"MyOptions_2 = %zd", MyOptions_2);
    NSLog(@"MyOptions_3 = %zd", MyOptions_3);
    NSLog(@"MyOptions_4 = %zd", MyOptions_4);
    NSLog(@"MyOptions_5 = %zd", MyOptions_5);
    NSLog(@"MyOptions_6 = %zd", MyOptions_6);
    NSLog(@"MyOptions_7 = %zd", MyOptions_7);
    NSLog(@"MyOptions_8 = %zd", MyOptions_8);
    
    
    /**
     *  All2
     */
    MyOptions startOption = MyOptions_0; //不变的起点
    MyOptions currentOption = MyOptions_0;
    MyOptions nowOption = MyOptions_0 | MyOptions_1 | MyOptions_2 | MyOptions_3 | MyOptions_4 | MyOptions_5 | MyOptions_6 | MyOptions_7 | 512;
    uint offset = 0;
    while (nowOption) {
    //        NSLog(@"1.nowOption=%zd - thisOption=%zd", nowOption, currentOption);
        //如果存在
        if ((nowOption & currentOption) == currentOption) {
            NSLog(@"- MyOptions_%d = %zd", offset, currentOption);
            
            //删除当前的
            nowOption ^= currentOption;
    //            NSLog(@"2.nowOption=%zd - thisOption=%zd", nowOption, currentOption);
        }
        //继续下一个位移
        currentOption = startOption << (++offset);
    //        NSLog(@"3.offset=%d - nowOption=%zd - thisOption=%zd", offset, nowOption, currentOption);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
