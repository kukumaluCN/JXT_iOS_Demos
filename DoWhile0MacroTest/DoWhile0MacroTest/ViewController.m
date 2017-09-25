//
//  ViewController.m
//  DoWhile0MacroTest
//
//  Created by JXT on 2017/9/25.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#define MACRO_TEST_0(_log_)          \
    NSLog(@"print log - %@", _log_); \
    NSLog(@"print no log");

#define MACRO_TEST_1(_log_)          \
{                                    \
    NSLog(@"print log - %@", _log_); \
    NSLog(@"print no log");          \
}

#define MACRO_TEST_2(_log_)          \
do {                                 \
    NSLog(@"print log - %@", _log_); \
    NSLog(@"print no log");          \
} while (0)

#define MACRO_TEST_3(_log_)          \
({                                   \
    NSLog(@"print log - %@", _log_); \
    NSLog(@"print no log");          \
}) //GCC提供了Statement-Expressions用以替代do{...}while(0);


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //http://www.jianshu.com/p/51ee5d028c76
    //http://www.cnblogs.com/lanxuezaipiao/p/3535626.html
    //http://blog.csdn.net/luoweifu/article/details/38563161
    
    if (1)
        MACRO_TEST_0(@"0");
//    else  //报错
//        NSLog(@"00");
    
    if (1)
        MACRO_TEST_1(@"1") //不能加分号
    else
        NSLog(@"11");
    
    if (1)
        MACRO_TEST_2(@"2");
    else
        NSLog(@"22");
    
    if (1)
        MACRO_TEST_3(@"3");
    else
        NSLog(@"33");

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
