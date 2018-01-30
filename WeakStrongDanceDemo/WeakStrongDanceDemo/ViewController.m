//
//  ViewController.m
//  WeakStrongDanceDemo
//
//  Created by JXT on 2018/1/30.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "ViewController.h"

#define WeakSelf(type) __weak typeof(type)weak##type = type
#define StrongSelf(type) __strong typeof(type)type = weak##type

@interface ViewController ()
@property (nonatomic, copy) void(^block)(void);
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  ##在宏里可以连接字符串。
     这里就是在block外把self付给weakself，然后block内把weakself还给self。
     block外部创建weakself，保证了不会有引用计数加一，内部强持有，可以保证在block执行前self不会被释放。
     */
    
    /**
     *  1.
     */
    NSLog(@"1.self - %p", &self);
    WeakSelf(self);
    NSLog(@"2.self - %p", &self);
    NSLog(@"3.weakself - %p", &weakself);

    self.block = ^{
        StrongSelf(self);
        NSLog(@"4.strong-self - %p", &self);
    };
    self.block();
    
    NSLog(@"5.self - %p", &self);
    
    
    /**
     *  2.
     */
    __weak typeof(self)weakself2 = self;
    NSLog(@"6.weakself2 - %p", &weakself2);
    NSLog(@"7.self - %p", &self);
    
    self.block = ^{
        __strong typeof(self)self = weakself2;
        NSLog(@"8.strong-self2 - %p", &self);
    };
    self.block();
    
    NSLog(@"9.self - %p", &self);

    
    /**
     *  3.
     */
    __weak ViewController *weakself3 = self;
    NSLog(@"10.weakself3 - %p", &weakself2);
    NSLog(@"11.self - %p", &self);
    
    self.block = ^{
        __strong ViewController *self = weakself3;
        NSLog(@"12.strong-self3 - %p", &self);
    };
    self.block();
    
    NSLog(@"13.self - %p", &self);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
