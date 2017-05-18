/***************************************************************
 //工程名称 : KVOForInstanceVarTest
 //文件名称 : TestModel.m
 //创建时间 : 2017/5/17
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "TestModel.h"

@implementation TestModel

// 手动设定KVO
- (void)setTestVar:(NSString *)testVar
{
    [self willChangeValueForKey:@"testVar"];
    _testVar = testVar;
    [self didChangeValueForKey:@"testVar"];
}

- (NSString *)testVar
{
    return _testVar;
}

//不加这个，监听到连续两次
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    // 如果监测到键值为testVar，则指定为非自动监听对象
    if ([key isEqualToString:@"testVar"])
    {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
