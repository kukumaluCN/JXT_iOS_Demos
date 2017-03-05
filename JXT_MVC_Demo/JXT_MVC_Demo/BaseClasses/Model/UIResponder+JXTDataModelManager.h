/***************************************************************
 //工程名称 : JXT_MVC_Demo
 //文件名称 : UIResponder+JXTDataModelManager.h
 //创建时间 : 2017/3/5
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/

#import <UIKit/UIKit.h>

@interface UIResponder (JXTDataModelManager)

/**
 前向型数据模型，用于正向数据通信，同步刷新UI（例如点击列表前，列表详情数据已经获取，只是加载显示）
 */
@property (nonatomic, strong, nonnull) id jxt_forwardDataModel;



/**
 回调型数据模型，用于迟后加载，异步回调刷新UI（例如点击列表前，列表详情数据未获取，跳转至新页面后异步加载）
 触发该属性set方法，回自动触发对应子类覆写的'jxt_reloadDataWithModelForView'方法

 @param callbackDataModel 设置数据源
 */
- (void)jxt_setCallbackDataModel:(nonnull id)callbackDataModel;

/**
 基类抽象方法，子类必须覆盖，根据数据源更新UI显示

 @param callbackDataModel 回调数据源
 */
- (void)jxt_refreshUIWithCallbackDataModel:(nonnull id)callbackDataModel;

@end
