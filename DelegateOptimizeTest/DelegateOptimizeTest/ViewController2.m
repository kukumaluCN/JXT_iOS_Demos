//
//  ViewController2.m
//  DelegateOptimizeTest
//
//  Created by JXT on 2017/1/12.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2
{
    //位段，每个域对应一个协议方法
    struct {
        BOOL respondsToCarryVC2TitleFetcher : 1;
        BOOL respondsToCarryVC2Message : 1;
        BOOL respondsToReceivedNetWorkDataDict : 1;
    }_delegateFlags;
}

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"第二页";
    
}

//侧滑返回未完成就会触发。。。
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    if (![self.navigationController.viewControllers containsObject:self])//等效[self.navigationController.viewControllers indexOfObject:self] == NSNotFound
//    {
//        if ([_delegate respondsToSelector:@selector(carryVC2Title:fetcher:)]) {
//            [_delegate carryVC2Title:self.navigationItem.title fetcher:self];
//        }
//        if ([_delegate respondsToSelector:@selector(carryVC2Message:)]) {
//            [_delegate carryVC2Message:@"a message"];
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if ([_delegate respondsToSelector:@selector(receivedNetWorkDataDict:)]) {
//                [_delegate receivedNetWorkDataDict:@{@"key":@"value"}];
//            }
//        });
//    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //self.navigationController == nil
    NSLog(@"viewDidDisappear-%@", self.navigationController.viewControllers);
    
    if (!self.navigationController || ![self.navigationController.viewControllers containsObject:self])
//    if (![self.navigationController.viewControllers containsObject:self])//等效[self.navigationController.viewControllers indexOfObject:self] == NSNotFound
    {
        [self executeDelegateMethods];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Methods
- (void)executeDelegateMethods
{
    //常规做法
//    if ([_delegate respondsToSelector:@selector(carryVC2Title:fetcher:)]) {
//        [_delegate carryVC2Title:self.navigationItem.title fetcher:self];
//    }
//    if ([_delegate respondsToSelector:@selector(carryVC2Message:)]) {
//        [_delegate carryVC2Message:@"a message"];
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if ([_delegate respondsToSelector:@selector(receivedNetWorkDataDict:)]) {
//            [_delegate receivedNetWorkDataDict:@{@"key":@"value"}];
//        }
//    });
    
    //利用位段，提升性能
    if (_delegateFlags.respondsToCarryVC2TitleFetcher) {
        [_delegate carryVC2Title:self.navigationItem.title fetcher:self];
    }
    if (_delegateFlags.respondsToCarryVC2Message) {
        [_delegate carryVC2Message:@"a message"];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_delegateFlags.respondsToReceivedNetWorkDataDict) {
            [_delegate receivedNetWorkDataDict:@{@"key":@"value"}];
        }
    });
}


#pragma mark - Set
- (void)setDelegate:(id<VC2DataSourceDelegate>)delegate
{
    _delegate = delegate;
    
    //检测协议方法是否实现，配置对应位域
    _delegateFlags.respondsToCarryVC2TitleFetcher = [_delegate respondsToSelector:@selector(carryVC2Title:fetcher:)];
    _delegateFlags.respondsToCarryVC2Message = [_delegate respondsToSelector:@selector(carryVC2Message:)];
    _delegateFlags.respondsToReceivedNetWorkDataDict = [_delegate respondsToSelector:@selector(receivedNetWorkDataDict:)];
}

@end
