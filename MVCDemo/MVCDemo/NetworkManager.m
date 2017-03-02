/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : NetworkManager.m
 //创建时间 : 2017/3/1
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "NetworkManager.h"

@implementation NetworkManager

+ (void)requestWithUrl:(NSString *)aUrl andCompletion:(NetworkCompletion)completion
{
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion(retDict, nil);
        }
    });
}

@end
