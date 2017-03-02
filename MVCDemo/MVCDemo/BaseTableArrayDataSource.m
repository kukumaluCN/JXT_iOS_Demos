/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseTableArrayDataSource.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseTableArrayDataSource.h"

#import "BaseTableViewCell.h"

static NSString *const kBaseTableViewCellId = @"baseTableViewCellId";


@interface BaseTableArrayDataSource ()
@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, copy) NSString * cellReuseIdentifier;
@end


@implementation BaseTableArrayDataSource

#pragma mark - Intial Methods
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"初始化方法非法！" reason:@"请使用'initWithCellClass:'初始化本类" userInfo:nil];
    return nil;
}
- (instancetype)initWithCellClass:(Class)cellClass
{
    if (self = [super init]) {
        self.cellClass = cellClass;
        self.cellReuseIdentifier = [NSString stringWithFormat:@"%@_%@", kBaseTableViewCellId, NSStringFromClass(cellClass)];
    }
    return self;
}


#pragma mark - Public Methods
- (void)setCellDataArray:(NSArray *)dataArray
{
    self.dataArray = dataArray;
}

- (id)getCellDataModelAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataArray[(NSUInteger) indexPath.row];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cellClass isSubclassOfClass:[BaseTableViewCell class]])
    {
        BaseTableViewCell *cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellReuseIdentifier];
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier];
        }
        
        if (self.dataArray.count > 0) {
            [cell configTableViewCellWithModel:self.dataArray[indexPath.row]];
        }
        
        return cell;
    }
    else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"cellClass类型非法，非BaseTableViewCell子类" userInfo:nil];
        return nil;
    }
}

@end
