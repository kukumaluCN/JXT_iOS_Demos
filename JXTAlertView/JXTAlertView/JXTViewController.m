//
//  JXTViewController.m
//  JXTAlertView
//
//  Created by JXT on 16/3/5.
//  Copyright © 2016年 JXT. All rights reserved.
//

#import "JXTViewController.h"

#import "JXTAlertView.h"
#import "JXTAlertViewController.h"

@interface JXTViewController ()

@end

@implementation JXTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"点击屏幕";
    
    UIButton * alertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alertBtn.frame = CGRectMake(0, 100, self.view.frame.size.width, 50);
    [alertBtn setTitle:@"alert视图" forState:UIControlStateNormal];
    [alertBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    alertBtn.backgroundColor = [UIColor grayColor];
    [alertBtn addTarget:self action:@selector(alertView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];
    
    UIButton * alertVCBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    alertVCBtn.frame = CGRectMake(0, CGRectGetMaxY(alertBtn.frame) + 20, self.view.frame.size.width, 50);
    [alertVCBtn setTitle:@"alert视图控制器" forState:UIControlStateNormal];
    [alertVCBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    alertVCBtn.backgroundColor = [UIColor grayColor];
    [alertVCBtn addTarget:self action:@selector(alertViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertVCBtn];
    
}

- (void)alertView:(UIButton *)btn
{
    [[JXTAlertView sharedAlertView] showAlertViewWithConfirmAction:^(NSString *inputText) {
        NSLog(@"输入内容：%@", inputText);
    } andReloadAction:^{
        [[JXTAlertView sharedAlertView] refreshVerifyImage:[VerifyNumberView verifyNumberImage]];
    }];
}

- (void)alertViewController:(UIButton *)btn
{
    JXTAlertViewController * alertVC = [[JXTAlertViewController alloc] initWithConfirmAction:^(NSString *inputText) {
        NSLog(@"输入内容：%@", inputText);
    } andCancelAction:^{
        NSLog(@"点击取消");
    }];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
