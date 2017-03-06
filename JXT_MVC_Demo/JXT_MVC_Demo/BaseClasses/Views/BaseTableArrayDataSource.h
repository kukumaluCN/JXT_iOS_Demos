/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseTableArrayDataSource.h
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface BaseTableArrayDataSource : NSObject <UITableViewDataSource>

/**
 TableViewDataSource代理共有类，构造单section、单样式cell的TableView

 @param cellClass cell具体实现类
 @return TableViewDataSource代理对象
 */
- (instancetype)initWithCellClass:(Class)cellClass;


/**
 TableView数据源模型数组
 */
@property (nonatomic, strong) NSArray * cellsDataArray;


/**
 获取

 @param indexPath tableView对应的indexPath
 @return 对应cell的数据源模型
 */
- (id)getCellDataModelAtIndexPath:(NSIndexPath *)indexPath;

@end
