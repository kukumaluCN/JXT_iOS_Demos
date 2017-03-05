/***************************************************************
//工程名称 : JXT_MVC_Demo
//文件名称 : LoginViewController.m
//创建时间 : 2017/3/4
//创建作者 : JXT
//版权归属 : 霖溦
//文件描述 :
***************************************************************/


#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) UILabel * tipLabel;
@end

@implementation LoginViewController

#pragma mark - Intial Methods


#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupBaseUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI and Layout
- (void)setupBaseUI
{
    self.navigationItem.title = @"登录";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5);
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击登录";
    [self.view addSubview:label];
    self.tipLabel = label;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _tipLabel.center = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.5);
}


#pragma mark - Other

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[[NSClassFromString(@"MainViewController") alloc] init] animated:YES];
}

@end
