/***************************************************************
 //工程名称 : KVOForInstanceVarTest
 //文件名称 : TestModel.h
 //创建时间 : 2017/5/17
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <Foundation/Foundation.h>

@interface TestModel : NSObject
{
    NSString *_testVar;
}
@property (nonatomic, strong) NSString * testProperty;


- (void)setTestVar:(NSString *)testVar;

- (NSString *)testVar;

@end
