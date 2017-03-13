/***************************************************************
 //工程名称 : ClassPropertyTest
 //文件名称 : MyObject.m
 //创建时间 : 2017/3/14
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "MyObject.h"

#import <objc/runtime.h>

static NSObject *__myobj_globalVariable = nil;

@implementation MyObject

+ (NSObject *)classProperty
{
    return objc_getAssociatedObject(self, _cmd);
}

+ (void)setClassProperty:(NSObject *)classProperty
{
    objc_setAssociatedObject(self, @selector(classProperty), classProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (void)setClassProperty2:(NSObject *)classProperty2
{
    __myobj_globalVariable = classProperty2;
}
+ (NSObject *)classProperty2
{
    return __myobj_globalVariable;
}

@end
