//
//  ViewController.m
//  KVCTest
//
//  Created by JXT on 2017/1/6.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "KVCObj.h"
#import "KVCSubObj.h"

#import "KVCContainer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[有趣的KVC－几行代码打造一个万能容器对象](http://www.jianshu.com/p/ad2d6681630e )
    
    KVCObj *obj = [[KVCObj alloc] init];
    
    /**
     *  1.无setter/getter方法也可以直接去找对应名称的变量操作
     */
//    obj.ivar = @"string";
//    [obj setValue:@"a string" forKey:NSStringFromSelector(@selector(ivar))];
//    NSLog(@"%@", [obj valueForKey:NSStringFromSelector(@selector(ivar))]);
    [obj setValue:@"a string" forKey:@"ivar"];
    NSLog(@"%@", [obj valueForKey:@"ivar"]);
    
    
    [obj setValue:@"a string 1" forKey:@"priIvar1"];
    NSLog(@"%@", [obj valueForKey:@"priIvar1"]);
    [obj setValue:@"a string 2" forKey:@"priIvar2"];
    NSLog(@"%@", [obj valueForKey:@"priIvar2"]);
    
    
    
    /**
     *  2.使用KVC会自动开/封箱
     */
    NSLog(@"%f", obj.floatNumber);
    [obj setValue:@0.01 forKey:@"floatNumber"];
    NSLog(@"%f", obj.floatNumber);
    
    obj.floatNumber = 0.123;
    NSLog(@"%@", [obj valueForKey:@"floatNumber"]);
    NSLog(@"%@", [[obj valueForKey:@"floatNumber"] class]);
    
    
    
    /**
     *  3.键路径
     */
    obj.subObj = [[KVCSubObj alloc] init];
    [obj setValue:@"a sub string" forKeyPath:@"subObj.subIvar"];
    NSLog(@"%@", obj.subObj.subIvar);
    NSLog(@"%@", [obj valueForKeyPath:@"subObj.subIvar"]);
    
    
    
    /**
     *  4.批处理
     */
    NSDictionary *keyValuesDict = @{
                                    @"string1":@"value1",
                                    @"string2":@"value2",
                                    @"string3":@"value3",
                                    @"string4":@"value4",
                                    @"string5":@"value5",
                                    @"str":@"value"
                                    };
    [obj setValuesForKeysWithDictionary:keyValuesDict];
    NSLog(@"%@", obj.string1);
    NSLog(@"%@", obj.string2);
    NSLog(@"%@", obj.string3);
    NSLog(@"%@", obj.string4);
    NSLog(@"%@", obj.string5);
    
    NSArray *keysArray = @[
                           @"string1",
                           @"string2",
                           @"string5"
                           ];
    NSDictionary *valuesDict = [obj dictionaryWithValuesForKeys:keysArray];
    NSLog(@"%@", valuesDict);
    
    
    
    /**
     *  5.快速运算
     */
    //@avg //获取平均数
    //@min //获取最小数
    //@max //获取最大数
    //@distinctUnionOfObjects //过滤重复值
    NSLog(@"%@", [obj valueForKeyPath:@"subObjs.@count"]);
    NSLog(@"%@", [[obj valueForKeyPath:@"subObjs.@count"] class]);
    
    
    
    /**
     *  6.用kvc实现一个万能容器对象的方法
     */
    KVCContainer *container = [[KVCContainer alloc] init];
    [container setValue:@"a test container" forKey:@"name"];
    [container setValue:@1024 forKey:@"size"];
    NSLog(@"\nname:%@\nsize:%@", [container valueForKey:@"name"], [container valueForKey:@"size"]);
    
    
    
    /**
     *  7.系统相关容器类之--CALayer
     */
    CALayer *layer = [CALayer layer];
    void (^aBlock)() = ^{
        NSLog(@"代码块");
    };
    [layer setValue:aBlock forKey:@"layerBlock"];
    [layer setValue:@"a property" forKey:@"extProperty"];
    
    void (^executeBlock)() = [layer valueForKey:@"layerBlock"];
    if (executeBlock) {
        executeBlock();
    }
    NSLog(@"%@", [layer valueForKey:@"extProperty"]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
