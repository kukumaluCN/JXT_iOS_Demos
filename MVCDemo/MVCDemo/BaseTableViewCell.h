/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseTableViewCell.h
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@end



@interface BaseTableViewCell (ConfigDataModelForCell)
/**
 配置cell数据，刷新UI，基类方法，子类实现最后回调，刷新UI
 
 @param dataModel 数据模型
 */
- (void)configTableViewCellWithModel:(id)dataModel;
@end
