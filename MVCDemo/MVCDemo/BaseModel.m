/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : BaseModel.m
 //创建时间 : 2017/3/1
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
