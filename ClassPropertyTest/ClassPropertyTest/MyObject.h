/***************************************************************
 //工程名称 : ClassPropertyTest
 //文件名称 : MyObject.h
 //创建时间 : 2017/3/14
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <Foundation/Foundation.h>

@interface MyObject : NSObject

//实例属性
@property (nonatomic, strong) NSObject * instanceProperty;

//类属性1(不加'class'修饰，点方法会报错)
@property (nonatomic, strong, class) NSObject * classProperty;

//类属性2
@property (nonatomic, strong, class) NSObject * classProperty2;

@end
