/***************************************************************
//工程名称 : MVCDemo
//文件名称 : BaseViewController.m
//创建时间 : 2017/3/2
//创建作者 : JXT
//版权归属 : 霖溦
//文件描述 :
***************************************************************/


#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Intial Methods


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
 
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"释放 - %@", [self class]);
}


#pragma mark - UI and Layout
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    NSLog(@"%lf", [UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"%lf", self.navigationController.navigationBar.bounds.size.height);
}

#pragma mark - Setter Getter Methods


#pragma mark - Target Methods


#pragma mark - Private Method



@end
