//
//  ViewController.m
//  NSErrorTest
//
//  Created by JXT on 2017/1/9.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

/**
 *  ErrorCode
 */
typedef NS_ENUM(NSInteger, NSErrorTestErrorCode) {
    NSErrorTestErrorCodeNil      = -1000,
    NSErrorTestErrorCodeBadInput = -2000,
    NSErrorTestErrorCodeOther    = -3000
};

/**
 *  ErrorDomain
 */
//简单框架，错误类型简单，使用单一域定位
static NSErrorDomain const NSErrorTestErrorDomain = @"NSErrorTestErrorDomain";
//复杂框架，错误类型复杂，使用详细域方便定位
static NSErrorDomain const NSErrorTestDetailErrorDomain = @"com.errortest.error.viewcontroller.configstring";

/**
 *  ErrorKey
 */
//自定义描述信息key
static NSString *const NSErrorTestCustomErrorKey = @"NSErrorTestCustomError";


@interface ViewController ()
@end

@implementation ViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"NSCocoaErrorDomain:%@", NSCocoaErrorDomain);
    
    /**
     *  1.传入error地址，error作为输出参数，内部定制的错误，外部获取错误
     */
    NSError *err = nil;
    [self configWithString:nil error:&err];
    if (err) {
        NSLog(@"error:%@", err);
        NSLog(@"domain:%@", err.domain);
        NSLog(@"code:%zd", err.code);
        NSLog(@"userInfo:%@", err.userInfo);
        NSLog(@"localizedFailureReason:%@", err.localizedFailureReason);
    }
    
    
    /**
     *  2.无意义的做法
     */
    NSError *err2 = nil;
    [self config2WithString:@"" error:err2];
    NSLog(@"---%@", err2);
    
    
    /**
     *  3.外部实现错误，内部捕获
     */
    NSError *err3 = [NSError errorWithDomain:NSErrorTestDetailErrorDomain code:NSErrorTestErrorCodeBadInput userInfo:@{NSLocalizedDescriptionKey:@"string length can not be zero"}];
    [self config3WithString:@"" error:err3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Methods
- (void)configWithString:(NSString *)string error:(NSError **)error
{
    if (string.length > 0)
    {
        NSLog(@"%@", string);
    }
    else
    {
        if (error)//判空，防止崩溃
        {
            *error = [NSError errorWithDomain:NSErrorTestErrorDomain code:NSErrorTestErrorCodeNil userInfo:@{NSLocalizedFailureReasonErrorKey:@"string can not be nil"}];
        }
    }
}

- (void)config2WithString:(NSString *)string error:(NSError *)error
{
    if (string.length > 0)
    {
        NSLog(@"%@", string);
    }
    else
    {
        error = [NSError errorWithDomain:@"com.config.nil" code:1000 userInfo:@{@"description":@"string can not be nil"}];
    }
}

- (void)config3WithString:(NSString *)string error:(NSError *)error
{
    if (string.length > 0)
    {
        NSLog(@"%@", string);
    }
    else
    {
        if (error)
        {
            NSLog(@"error:%@", error);
            NSLog(@"domain:%@", error.domain);
            NSLog(@"code:%zd", error.code);
            NSLog(@"userInfo:%@", error.userInfo);
            NSLog(@"localizedDescription:%@", error.localizedDescription);
        }
    }
}

@end
