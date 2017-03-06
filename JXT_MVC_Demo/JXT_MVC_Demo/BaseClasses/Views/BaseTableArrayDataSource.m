/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseTableArrayDataSource.m
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseTableArrayDataSource.h"

#import "UIResponder+JXTDataModelManager.h"

static NSString *const kBaseTableViewCellId = @"baseTableViewCellId";


@interface BaseTableArrayDataSource ()
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
- (id)getCellDataModelAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellsDataArray[(NSUInteger) indexPath.row];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellsDataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cellClass isSubclassOfClass:[UITableViewCell class]])
    {
        UITableViewCell *cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:self.cellReuseIdentifier];
        if (!cell) {
            cell = [tableView dequeueReusableCellWithIdentifier:self.cellReuseIdentifier];
        }
        
        if (self.cellsDataArray.count > 0) {
            [cell jxt_setCallbackDataModel:self.cellsDataArray[indexPath.row]];
        }
        
        return cell;
    }
    else {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"cellClass类型非法，非BaseTableViewCell子类" userInfo:nil];
        return nil;
    }
}

#pragma mark - Other
- (void)dealloc
{
    NSLog(@"释放 - %@", [self class]);
}

@end
