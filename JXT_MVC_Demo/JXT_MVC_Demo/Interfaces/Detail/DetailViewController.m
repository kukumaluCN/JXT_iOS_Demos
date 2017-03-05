/***************************************************************
//工程名称 : MVCDemo
//文件名称 : DetailViewController.m
//创建时间 : 2017/3/2
//创建作者 : JXT
//版权归属 : 霖溦
//文件描述 :
***************************************************************/


#import "DetailViewController.h"

#import "MainModel.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Intial Methods


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    SubMainModel *subMainModel = self.jxt_forwardDataModel;
    self.navigationItem.title = subMainModel.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Other

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
