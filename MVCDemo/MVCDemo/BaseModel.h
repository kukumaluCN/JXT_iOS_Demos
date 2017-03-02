/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseModel.h
 //创建时间 : 2017/3/1
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/**
 Model基类KVC构造

 @param dict 数据字典
 @return model
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
