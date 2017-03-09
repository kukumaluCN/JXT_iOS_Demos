/***************************************************************
 //工程名称 : JXT_MVCP_Demo
 //文件名称 : BaseNetworkManager.h
 //创建时间 : 2017/3/3
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <Foundation/Foundation.h>

#define JXT_NOT_NULL_OR_EMPTY_OF_ARRAY(_ARRAY___) (_ARRAY___ && [_ARRAY___ isKindOfClass:[NSArray class]] && [_ARRAY___ count])
#define JXT_NOT_NULL_OR_EMPTY_OF_DICTIONARY(_DICTIONARY___) (_DICTIONARY___ && [_DICTIONARY___ isKindOfClass:[NSDictionary class]] && [_DICTIONARY___ count])

typedef void(^MVCPBaseNetworkCompletion)(id responseData, NSError *aError);

/**
 错误域生成

 @param subDomain 子域信息
 @return 错误域
 */
static inline NSErrorDomain BaseNetworkErrorDomain(NSString *subDomain)
{
    if (subDomain.length > 0) {
        return [NSString stringWithFormat:@"BaseNetworkManager_%@", subDomain];
    }
    return @"BaseNetworkManager";
}

static inline NSError *BaseNetworkError(id url, NSInteger code, NSDictionary *userInfo)
{
    NSURL *absoluteUrl = nil;
    if ([url isKindOfClass:[NSURL class]])
    {
        absoluteUrl = url;
    }
    else if ([url isKindOfClass:[NSString class]])
    {
        absoluteUrl = [NSURL URLWithString:url];
    }
    //domain为nil，闪退
    return [NSError errorWithDomain:BaseNetworkErrorDomain(absoluteUrl.path) code:code userInfo:userInfo];
}

@interface BaseNetworkManager : NSObject

+ (void)requestWithUrl:(NSString *)aUrl andCompletion:(MVCPBaseNetworkCompletion)completion;

@end
