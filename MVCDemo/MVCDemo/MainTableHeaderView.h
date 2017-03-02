/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableHeaderView.h
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <UIKit/UIKit.h>

@class MainModel;
@interface MainTableHeaderView : UIView

/**
 配置headerView数据源模型

 @param mainModel 数据源模型
 */
- (void)configTableHeaderViewWith:(MainModel *)mainModel;

@end
