/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : NetworkManager.h
 //创建时间 : 2017/3/1
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <Foundation/Foundation.h>

typedef void(^NetworkCompletion)(NSDictionary *aDict, NSError *aError);

@interface NetworkManager : NSObject

+ (void)requestWithUrl:(NSString *)aUrl andCompletion:(NetworkCompletion)completion;

@end
