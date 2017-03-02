/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableView.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "MainTableView.h"

#import "MainTableHeaderView.h"
#import "MainTableFooterView.h"
#import "MainTableViewCell.h"

#import "BaseTableArrayDataSource.h"
#import "MainModel.h"

@interface MainTableView ()
@property (nonatomic, strong) MainTableHeaderView * mainTableHeaderView;
@property (nonatomic, strong) MainTableFooterView * mainTableFooterView;

@property (nonatomic, strong) BaseTableArrayDataSource * mainDataSource;
@end


@implementation MainTableView

#pragma mark - Intial Methods
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self configTableView];
    }
    return self;
}

#pragma mark - UI and Layout
- (void)configTableView
{
    self.tableHeaderView = self.mainTableHeaderView;
    self.tableFooterView = self.mainTableFooterView;
    
    //设置数据源代理
    BaseTableArrayDataSource * mainDataSource = [[BaseTableArrayDataSource alloc] initWithCellClass:[MainTableViewCell class]];
    self.mainDataSource = mainDataSource;
    self.dataSource = mainDataSource;
}
- (MainTableHeaderView *)mainTableHeaderView
{
    if (!_mainTableHeaderView) {
        _mainTableHeaderView = [[MainTableHeaderView alloc] initWithFrame:CGRectZero];
        _mainTableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _mainTableHeaderView;
}
- (MainTableFooterView *)mainTableFooterView
{
    if (!_mainTableFooterView) {
        _mainTableFooterView = [[MainTableFooterView alloc] initWithFrame:CGRectZero];
        _mainTableFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _mainTableFooterView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainTableHeaderView.frame = CGRectMake(0, 0, self.bounds.size.width, 100);
    _mainTableFooterView.frame = CGRectMake(0, _mainTableHeaderView.bounds.size.height, self.bounds.size.width, self.bounds.size.height-_mainTableHeaderView.bounds.size.height-20);
}

@end



@implementation MainTableView (ConfigDataForTableView)
- (void)reloadDataWithDataModel:(MainModel *)mainModel
{
    //头
    [self.mainTableHeaderView configTableHeaderViewWith:mainModel];
    //尾
    [self.mainTableFooterView loadSuccess];
    self.tableFooterView = nil;
    self.mainTableFooterView = nil;
    //先替换表数据源
    [self.mainDataSource setCellDataArray:mainModel.listDatas];
    
    //后刷新协议方法
    [super reloadData];
}

- (id)cellDataModelAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.mainDataSource getCellDataModelAtIndexPath:indexPath];
}
@end



@implementation MainTableView (TableFooterViewMethods)
- (void)loadFailureMessage:(NSString *)errorMag andReloadWithHandler:(void (^)())handler
{
    [self.mainTableFooterView loadFailureMessage:errorMag andReloadWithHandler:handler];
}
@end
