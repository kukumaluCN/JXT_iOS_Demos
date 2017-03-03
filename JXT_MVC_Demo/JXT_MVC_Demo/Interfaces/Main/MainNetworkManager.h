/***************************************************************
 //工程名称 : JXT_MVCP_Demo
 //文件名称 : MainNetworkManager.h
 //创建时间 : 2017/3/3
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseNetworkManager.h"

@interface MainNetworkManager : BaseNetworkManager

+ (void)requestMainVCListDataCompletion:(_Nonnull MVCPBaseNetworkCompletion)completion;

@end
