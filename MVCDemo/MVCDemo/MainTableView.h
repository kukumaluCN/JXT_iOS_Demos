/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableView.h
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface MainTableView : UITableView

@end



@class MainModel;
@interface MainTableView (ConfigDataForTableView)
/**
 重载tableView数据源，刷新列表，代替父类的'reloadData'方法

 @param mainModel 数据源模型
 */
- (void)reloadDataWithDataModel:(MainModel *)mainModel;

/**
 获取对应indexPath的cell的数据源模型

 @param indexPath indexPath
 @return cell的数据源模型
 */
- (id)cellDataModelAtIndexPath:(NSIndexPath *)indexPath;
@end



@interface MainTableView (TableFooterViewMethods)
/**
 加载失败列表样式显示
 
 @param errorMag 失败提示信息
 @param handler 加载失败点击方法回调
 */
- (void)loadFailureMessage:(NSString *)errorMag andReloadWithHandler:(void(^)())handler;
@end
