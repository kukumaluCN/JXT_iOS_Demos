//
//  ContainerViewController.m
//  ChildViewControllerTest
//
//  Created by JXT on 2017/2/14.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ContainerViewController.h"

#import "VC1.h"
#import "VC2.h"
#import "VC3.h"

@interface ContainerViewController ()
@property (nonatomic, strong) UIViewController * currentVC;

@property (nonatomic, strong) VC1 * firstVC;
@property (nonatomic, strong) VC2 * secondVC;
@property (nonatomic, strong) VC3 * thirdVC;
@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //参考
    //http://blog.sina.com.cn/s/blog_7b9d64af0101d6p7.html
    //http://blog.csdn.net/hmt20130412/article/details/34523235
    
    [self setupTopBarUI];
    [self setupBaseUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTopBarUI
{
    NSArray *titles = @[@"VC1", @"VC2", @"VC3"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:titles];
    segmentControl.frame = CGRectMake(0, 0, 200, 35);
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentControl;
}
- (void)setupBaseUI
{
    self.firstVC = [[VC1 alloc] init];
    self.firstVC.view.frame = self.view.bounds;//会触发vc1的viewDidLoad
    [self addChildViewController:self.firstVC];
    
    self.secondVC = [[VC2 alloc] init];
    self.secondVC.view.frame = self.view.bounds;
    
    self.thirdVC = [[VC3 alloc] init];
    self.thirdVC.view.frame = self.view.bounds;
    
    //默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [self.view addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
}

- (void)segmentControlAction:(UISegmentedControl *)segmentedControl
{
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
            [self replaceController:self.currentVC toNewController:self.firstVC];
            break;
        case 1:
            [self replaceController:self.currentVC toNewController:self.secondVC];
            break;
        case 2:
            [self replaceController:self.currentVC toNewController:self.thirdVC];
            break;
        default:
            break;
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    //调用addChildViewController之前会自动调用newController的willMoveToParentViewController
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished)
        {
            //addChildViewController之后手动添加的didMoveToParentViewController
            [newController didMoveToParentViewController:self];
            
            //删除之前oldController之前手动添加的willMoveToParentViewController
            [oldController willMoveToParentViewController:nil];
            //调用removeFromParentViewController之后会自动调用oldController的didMoveToParentViewController
            [oldController removeFromParentViewController];
            
            self.currentVC = newController;
        }
        else
        {
            self.currentVC = oldController;
        }
    }];
}

@end
