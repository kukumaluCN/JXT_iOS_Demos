/***************************************************************
 //工程名称 : JXT_MVCP_Demo
 //文件名称 : MainNetworkManager.m
 //创建时间 : 2017/3/3
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "MainNetworkManager.h"

#import "MainModel.h"

@implementation MainNetworkManager

+ (void)requestMainVCListDataCompletion:(MVCPBaseNetworkCompletion)completion
{
    //模拟返回数据
    NSDictionary *retDict = @{
                              @"headUrl":@"头像",
                              @"nameText":@"用户名字",
                              @"listDatas":@[
                                      @{@"order":@1, @"title":@"title1"},
                                      @{@"order":@2, @"title":@"title2"},
                                      @{@"order":@3, @"title":@"title3"},
                                      @{@"order":@4, @"title":@"title4"},
                                      @{@"order":@5, @"title":@"title5"},
                                      @{@"order":@6, @"title":@"title6"},
                                      @{@"order":@7, @"title":@"title7"},
                                      @{@"order":@8, @"title":@"title8"},
                                      @{@"order":@9, @"title":@"title9"},
                                      @{@"order":@10, @"title":@"title10"},
                                      ]
                              };
    
    NSString *absoluteUrlString = @"scheme://host.domain/path/filename/test";
    
    [BaseNetworkManager requestWithUrl:absoluteUrlString andCompletion:^(id responseData, NSError *aError) {
        if (!completion) {
            NSAssert(NO, @"completion can not be NULL!");
        }
        if (aError == nil && JXT_NOT_NULL_OR_EMPTY_OF_DICTIONARY(retDict)) //应该是responseData，这里是伪数据源
        {
            //数据解析
            MainModel *mainModel = [MainModel modelWithDict:retDict];
            
            if (mainModel)
            {
                completion(mainModel, nil);
            }
            else
            {
                //错误处理根据业务场景，单纯的toast提示逻辑尽量在本类完成，和vc无关
                completion(nil, BaseNetworkError(absoluteUrlString, NSURLErrorCannotDecodeContentData, nil));
                NSLog(@"弹窗提示：mainModel==nil");
            }
        }
        else
        {
            completion(nil, aError);
            NSLog(@"弹窗提示：%@", aError.debugDescription);
        }
    }];
}

@end
