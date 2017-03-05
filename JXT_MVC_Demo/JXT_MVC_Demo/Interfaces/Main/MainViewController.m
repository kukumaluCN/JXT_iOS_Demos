/***************************************************************
//工程名称 : MVCDemo
//文件名称 : MainViewController.m
//创建时间 : 2017/3/1
//创建作者 : JXT
//版权归属 : 霖溦
//文件描述 :
***************************************************************/


#import "MainViewController.h"
#import "DetailViewController.h"

#import "MainTableView.h"

#import "MainModel.h"

#import "MainNetworkManager.h"


@interface MainViewController () <UITableViewDelegate>

@property (nonatomic, strong) MainTableView * mainTableView;

@end


@implementation MainViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configBaseUI];
    
    [self networkRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UI and Layout
- (void)configBaseUI
{
    self.view.backgroundColor = [UIColor colorWithRed:241/255. green:241/255. blue:241/255. alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = NSStringFromClass([self class]);

    self.mainTableView = ({
        MainTableView *mainTableView = [[MainTableView alloc] initWithDelegate:self];
        mainTableView;
    });
    [self.view addSubview:self.mainTableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
        
    self.mainTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:detailVC];
//    detailVC.subMainModel = [self.mainTableView cellDataModelAtIndexPath:indexPath];
    detailVC.jxt_forwardDataModel = [self.mainTableView cellDataModelAtIndexPath:indexPath];
    [self presentViewController:nvc animated:YES completion:NULL];
}


#pragma mark - Network
- (void)networkRequest
{
    static NSInteger failureCount = 0;
    
    [MainNetworkManager requestMainVCListDataCompletion:^(id responseData, NSError *aError) {
        if ([responseData isKindOfClass:[MainModel class]] && aError == nil)
        {
            if (failureCount > 1)
            {
                failureCount = 0;
                MainModel *mainModel = responseData;
                [self.mainTableView jxt_setCallbackDataModel:mainModel];
            }
            else
            {
                failureCount ++;
                __weak typeof(self)ws = self;
                [self.mainTableView loadFailureMessage:[NSString stringWithFormat:@"失败计数+%zd，请点击屏幕重试", failureCount] andReloadWithHandler:^{
                    [ws networkRequest];
                }];
            }
        }
        else
        {
            __weak typeof(self)ws = self;
            [self.mainTableView loadFailureMessage:nil andReloadWithHandler:^{
                [ws networkRequest];
            }];
            NSLog(@"%@", aError.localizedDescription);
        }
    }];
}

@end
