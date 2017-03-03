/***************************************************************
 //工程名称 : MVCDemo
 //文件名称 : MainModel.h
 //创建时间 : 2017/3/1
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "BaseModel.h"

@interface SubMainModel : BaseModel

@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, copy) NSString * title;

@end


@interface MainModel : BaseModel

@property (nonatomic, copy) NSString * headUrl;
@property (nonatomic, copy) NSString * nameText;
@property (nonatomic, strong) NSArray <SubMainModel *>* listDatas; //SubMainModel数组

+ (MainModel *)modelWithDict:(NSDictionary *)dict;

@end



