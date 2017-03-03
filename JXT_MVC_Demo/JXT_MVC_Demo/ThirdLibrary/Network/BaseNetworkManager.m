/***************************************************************
 //工程名称 : JXT_MVCP_Demo
 //文件名称 : BaseNetworkManager.m
 //创建时间 : 2017/3/3
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseNetworkManager.h"

@implementation BaseNetworkManager

//模拟封装网络请求基本方法
+ (void)requestWithUrl:(NSString *)aUrl andCompletion:(MVCPBaseNetworkCompletion)completion
{
    NSString *requestUrl = aUrl;
    NSLog(@"模块-%@-网络请求Url%@", [self class], requestUrl);
    //模拟请求过程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion(nil, nil);
        }
    });
}

@end
