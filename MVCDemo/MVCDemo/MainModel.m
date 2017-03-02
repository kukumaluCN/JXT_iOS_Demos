/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainModel.m
 //创建时间 : 2017/3/1
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 : 
 ***************************************************************/


#import "MainModel.h"

@implementation MainModel

+ (MainModel *)modelWithDict:(NSDictionary *)dict
{
    return [[MainModel alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict])
    {
        if ([self.listDatas isKindOfClass:[NSArray class]])
        {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *subDict in self.listDatas)
            {
                SubMainModel *subModel = [SubMainModel subModelWithDict:subDict];
                [arr addObject:subModel];
            }
            self.listDatas = [NSArray arrayWithArray:arr];
        }
    }
    return self;
}

@end



@implementation SubMainModel

+ (SubMainModel *)subModelWithDict:(NSDictionary *)dict
{
    return [[SubMainModel alloc] initWithDict:dict];
}

@end
