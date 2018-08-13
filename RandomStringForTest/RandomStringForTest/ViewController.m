//
//  ViewController.m
//  RandomStringForTest
//
//  Created by JXT on 2018/8/13.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "NSString+JXTRandomString.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    testButton.bounds = CGRectMake(0, 0, 100, 50);
    testButton.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5);
    [testButton setTitle:@"生成随机串" forState:UIControlStateNormal];
    testButton.backgroundColor = [UIColor orangeColor];
    [testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
}


- (void)testButtonAction:(UIButton *)aSender
{
    NSString *testString = @"测试字符串20180813ABCDEFG!@#$%^&*()_+测试字符串20180813ABCDEFG!@#$%^&*()_+测试字符串20180813ABCDEFG!@#$%^&*()_+";
    NSLog(@"测试字符串：%zd - %@", testString.length, testString);
    NSString *randomLengthTestString = [testString jxt_stringWithRandomLength];
    NSLog(@"随机长度的测试字符串：%zd - %@", randomLengthTestString.length, randomLengthTestString);
    
    NSString *r = [NSString jxt_randomStringWithLength:10];
    NSLog(@"随机字符串 - %@", r);
    
    NSLog(@"随机12位数字字符串 - %@", [NSString jxt_randomDigitsStringWithLength:12]);
    NSLog(@"随机4位数字字符串 - %@", [NSString jxt_random4Digits]);
    NSLog(@"随机6位数字字符串 - %@", [NSString jxt_random6Digits]);
}

@end
