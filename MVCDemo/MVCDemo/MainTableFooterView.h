/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainTableFooterView.h
 //创建时间 : 2017/3/2
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <UIKit/UIKit.h>

@interface MainTableFooterView : UIView

/**
 加载失败样式显示

 @param errorMag 失败提示信息
 @param handler 加载失败点击方法回调
 */
- (void)loadFailureMessage:(NSString *)errorMag andReloadWithHandler:(void(^)())handler;

/**
 加载成功样式配置
 */
- (void)loadSuccess;

@end
