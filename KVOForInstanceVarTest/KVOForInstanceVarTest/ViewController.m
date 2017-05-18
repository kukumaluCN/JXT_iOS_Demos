//
//  ViewController.m
//  KVOForInstanceVarTest
//
//  Created by JXT on 2017/5/17.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"

#import "TestModel.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger number1;

@property (nonatomic, strong) TestModel * testModel;
@end

@implementation ViewController
{
    NSInteger _number2;
}

#pragma mark - KVO
- (void)setNumber2:(NSInteger)number2
{
    [self willChangeValueForKey:@"number2"];
    _number2 = number2;
    [self didChangeValueForKey:@"number2"];
}
- (NSInteger)number2
{
    return _number2;
}
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    // 如果监测到键值为testVar，则指定为非自动监听对象
    if ([key isEqualToString:@"number2"])
    {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     *  1.
     */
    [self addObserver:self forKeyPath:@"number1" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"number2" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    /**
     *  2.
     */
    TestModel *testModel = [[TestModel alloc] init];
    self.testModel = testModel;
    
    [self addObserver:self forKeyPath:@"testModel.testProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"testModel.testVar" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [testModel addObserver:self forKeyPath:@"testProperty" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [testModel addObserver:self forKeyPath:@"testVar" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.number1 = arc4random_uniform(1000);
    self.number2 = arc4random_uniform(1000);
    
    //直接改变实例变量，不触发kvo
//    _number1 = arc4random_uniform(1000);
//    _number2 = arc4random_uniform(1000);
    
    self.testModel.testProperty = [NSString stringWithFormat:@"testProperty - %zd", arc4random_uniform(1000)];
    self.testModel.testVar = [NSString stringWithFormat:@"testVar - %zd", arc4random_uniform(1000)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"number1"]) {
        NSLog(@"0 - %@ - %@", keyPath, change);
    }
    else if ([keyPath isEqualToString:@"number2"]) {
        NSLog(@"00 - %@ - %@", keyPath, change);
    }
    
    
    if ([keyPath isEqualToString:@"testModel.testProperty"]) {
        NSLog(@"1 - %@ - %@", keyPath, change);
    }
    else if ([keyPath isEqualToString:@"testModel.testVar"]) {
        NSLog(@"2 - %@ - %@", keyPath, change);
    }
    else if ([keyPath isEqualToString:@"testProperty"]) {
        NSLog(@"3 - %@ - %@", keyPath, change);
    }
    else if ([keyPath isEqualToString:@"testVar"]) {
        NSLog(@"4 - %@ - %@", keyPath, change);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
