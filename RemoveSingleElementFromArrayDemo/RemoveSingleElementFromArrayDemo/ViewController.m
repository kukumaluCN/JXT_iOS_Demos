//
//  ViewController.m
//  RemoveSingleElementFromArrayDemo
//
//  Created by JXT on 2018/4/8.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray <NSNumber *>*totalArray = @[@1, @2, @2, @3, @3, @3, @4, @4, @4, @4];
    NSArray <NSNumber *>*removeArray = @[@2, @3, @4, @4, @2];
    NSLog(@"totalArray - %@", totalArray);
    NSLog(@"removeArray - %@", removeArray);

    NSMutableArray <NSNumber *>*testArray = [NSMutableArray arrayWithArray:totalArray];
    [testArray removeObject:@3];
    NSLog(@"removeObject - %@", testArray);
    
    testArray = [NSMutableArray arrayWithArray:totalArray];
    [testArray removeObjectsInArray:removeArray];
    NSLog(@"removeObjectsInArray - %@", testArray);
    
    /**
     *  数组执行元素删除，会删除相同的所有元素值，而不是只删除单个
     */
    /**
     *  在某些业务场景中，只是想删除单一的一个元素，而不是同值的所有元素，类似的例如数据池的取用
     */
    
    
    /**
     *  以下采用遍历数组匹配记录index值，并移除特定indexSet集合的方式处理数组
     */
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    [removeArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull removeItem, NSUInteger removeIdx, BOOL * _Nonnull removeStop) {
        [totalArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull totalItem, NSUInteger totalIdx, BOOL * _Nonnull totalStop) {
            //匹配，如果已经记录index，排除
            if ([removeItem isEqualToNumber:totalItem] && ![indexSet containsIndex:totalIdx]) {
                [indexSet addIndex:totalIdx]; //记录index
                *totalStop = YES; //停止遍历
            }
        }];
    }];
    NSLog(@"indexSet - %@", indexSet);

    testArray = [NSMutableArray arrayWithArray:totalArray];
    [testArray removeObjectsAtIndexes:indexSet];
    NSLog(@"removeObjectsAtIndexes - %@", testArray);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
