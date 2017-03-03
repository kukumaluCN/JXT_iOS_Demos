/***************************************************************
 //工程名称 : JXT_MVC_Demo
 //文件名称 : UIView+JXTDataModelManager.h
 //创建时间 : 2017/3/3
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface UIView (JXTDataModelManager)

/**
 数据源模型
 */
@property (nonatomic, strong) id jxt_dataModel;

/**
 基类抽象方法，子类必须覆盖
 */
- (void)jxt_reloadData;

/**
 刷新cell布局
 */
- (void)jxt_updateLayoutImmediately;

@end
