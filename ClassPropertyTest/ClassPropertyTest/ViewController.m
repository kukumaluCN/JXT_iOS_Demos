//
//  ViewController.m
//  ClassPropertyTest
//
//  Created by JXT on 2017/3/14.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "MyObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //从Xcode 8开始，LLVM已经支持Objective-C显式声明类属性了，这是为了与Swift中的类属性互操作而引入的。
    
    //创建一个类属性很简单，主要有以下几个步骤：
    //1. 使用@property (class)来声明一个类属性；
    //2. 为类属性创建一个存储变量，通常为全局变量；
    //3. 实现类属性的getter与setter方法，如果是只读属性，只需要实现getter方法。
    
    //http://blog.csdn.net/u011619283/article/details/53139113
    
    MyObject.classProperty = @"a string";
    NSLog(@"classProperty = %@", MyObject.classProperty);
    
    MyObject.classProperty = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    NSLog(@"classProperty = %@", MyObject.classProperty);
    
    
    
    MyObject.classProperty2 = @(999);
    NSLog(@"classProperty2 = %@", MyObject.classProperty2);
    
    MyObject.classProperty2 = self;
    NSLog(@"classProperty2 = %@", MyObject.classProperty2);
    
    
    
    MyObject *obj = [[MyObject alloc] init];
    obj.instanceProperty = @"string";
    NSLog(@"instanceProperty = %@", obj.instanceProperty);
    obj.instanceProperty = self;
    NSLog(@"instanceProperty = %@", obj.instanceProperty);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
