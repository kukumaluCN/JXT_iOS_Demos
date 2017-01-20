//
//  ViewController.m
//  CategoryDelegateUnsafeTest
//
//  Created by JXT on 2017/1/20.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

#import "UIView+MyExt1.h"
#import "UIView+MyExt2.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //打印UIView的方法列表
    [self printMethodsListForClass:[UIView class]];
    
    //根据方法列表可知，靠前添加的方法，其对应实现的协议方法有效，会覆盖后添加的方法
    //方法添加顺序根据实验，发现和文件引入工程的顺序有关，后添加的文件，其实现有效，即后添加的文件，其方法列表顺序靠前
    //如果系统API中有类似实现，例如WKWebView的tap手势，开发者后添加的分类中的同样的协议方法会覆盖系统的实现，造成不可预计的bug
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 300, 100)];
    testView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:testView];
    [testView jxt_addTextField1];
    
    UIView *testView2 = [[UIView alloc] initWithFrame:CGRectMake(50, 250, 300, 100)];
    testView2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:testView2];
    [testView2 jxt_addTextField2];
}

- (void)printMethodsListForClass:(Class)class
{
    unsigned int count;
    Method *methods = class_copyMethodList(class, &count);
    
    NSMutableArray *myMethods = [NSMutableArray array];
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        
        NSLog(@"%d.系统方法  %@", i+1, name);
        if ([name hasPrefix:@"jxt_"])
        {
            [myMethods addObject:name];
        }
    }
    
    NSLog(@"================================");
    
    [myMethods enumerateObjectsUsingBlock:^(NSString * _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%zd.我的方法  %@", idx+1, name);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
