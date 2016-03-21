//
//  JXTNavigationController.m
//  ScrollScale
//
//  Created by JXT on 16/3/14.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXT_iOS_Demos
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***



#import "JXTNavigationController.h"

@interface JXTNavigationController ()

@end

@implementation JXTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    UIViewController * topVC = self.topViewController;
//    return [topVC preferredStatusBarStyle];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
