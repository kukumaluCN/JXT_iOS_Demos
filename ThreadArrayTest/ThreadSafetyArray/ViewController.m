//
//  ViewController.m
//  ThreadSafetyArray
//
//  Created by JXT on 2017/2/10.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //如何实现一个线程安全的NSMutabeArray，以保证多个线程对数组操作（遍历，插入，删除）的安全？
    //https://www.zhihu.com/question/35590962
    
    //iOS开发多线程之队列组——下载合并图片
    //http://blog.csdn.net/sunnyboy9/article/details/44893563
    
    //iOS 线程安全之@synchronized的用法
    //http://www.cnblogs.com/jukaiit/p/5570056.html
    
    //iOS线程安全数组
    //http://blog.csdn.net/idaretobe/article/details/22191103
    
    
    UIButton *testButton1 = [self createTestButtonWithTitle:@"GCD-group" frame:CGRectMake(100, 50, 100, 50)];
    [self.view addSubview:testButton1];
    
    UIButton *testButton2 = [self createTestButtonWithTitle:@"GCD-apply" frame:CGRectMake(100, 120, 100, 50)];
    [self.view addSubview:testButton2];
    
    UIButton *testButton3 = [self createTestButtonWithTitle:@"GCD-async" frame:CGRectMake(100, 190, 100, 50)];
    [self.view addSubview:testButton3];
    
    
    //测试滑动
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.text = @"@synchronized 的作用是创建一个互斥锁，保证此时没有其它线程对self对象进行修改。这个是objective-c的一个锁定令牌，防止self对象在同一时间内被其它线程访问，起到线程的保护作用。";
    textView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:textView];
    
    
    //测试动画是否卡顿
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(100, 450, 50, 50)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
    rotationAnimation.duration = 4;
    rotationAnimation.cumulative = YES;//从上次的值之后继续执行，保持连续性
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;//防止动画在切入后台再切回时停止
    rotationAnimation.fillMode = kCAFillModeForwards;
    [testView.layer addAnimation:rotationAnimation forKey:nil];
}

- (UIButton *)createTestButtonWithTitle:(NSString *)title frame:(CGRect)frame
{
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    testButton.frame = frame;
    [testButton setTitle:title forState:UIControlStateNormal];
    testButton.backgroundColor = [UIColor orangeColor];
    [testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return testButton;
}
- (void)testButtonAction:(UIButton *)aSender
{
    if ([aSender.currentTitle isEqualToString:@"GCD-group"])
    {
        [self threadTestArray1_group];
    }
    else if ([aSender.currentTitle isEqualToString:@"GCD-apply"])
    {
        [self threadTestArray2_apply];
    }
    else if ([aSender.currentTitle isEqualToString:@"GCD-async"])
    {
        [self threadTestArray3_async];
    }
}


//测试循环数
static NSInteger const kLoopCount = 30000;


//主线程卡死！！！性能最差
//30000次循环 [NSThread currentThread]
//CPU    140%
//Memory 80M
//Time   13.128s
//30000次循环 [NSThread sleepForTimeInterval:0.001]
//CPU    120%
//Memory 90M
//Time   13.098s
- (void)threadTestArray1_group
{
    NSLog(@"开始");
    NSDate *beginDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //创建大量线程时卡死主线程
    for (int i = 0; i < kLoopCount; i ++)
    {
        dispatch_group_async(group, queue, ^{
            
            NSNumber *randomNumber = @(arc4random_uniform(1000));
//            NSLog(@"1>%@", [NSThread currentThread]);
            NSLog(@"获取-%d", i);
            [NSThread sleepForTimeInterval:0.001];
            
            //加了锁之后，顺序不再完全固定
            @synchronized (array) {
//                NSLog(@"2>%@", [NSThread currentThread]);
                NSLog(@"写入-%d", i);
                [array addObject:[NSString stringWithFormat:@"%d-%@", i, randomNumber]];
            }
        });
    }
    dispatch_group_notify(group, queue, ^{
        NSLog(@"%@", array);
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:beginDate];
        NSLog(@"结束：%.3lf", time);
    });
}


//主线程没有卡死，综合较好
//30000次循环 [NSThread currentThread]
//CPU    50%
//Memory 38M
//Time   13.442s
//30000次循环 [NSThread sleepForTimeInterval:0.001]
//CPU    40%
//Memory 38M
//Time   18.830s
- (void)threadTestArray2_apply
{
    NSLog(@"开始");
    NSDate *beginDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray array];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        dispatch_apply(kLoopCount, queue, ^(size_t i) {
            NSNumber *randomNumber = @(arc4random_uniform(1000));
//            NSLog(@"1>%@", [NSThread currentThread]);
            NSLog(@"获取-%zd", i);
            [NSThread sleepForTimeInterval:0.001];
            
            //加了锁之后，顺序不再完全固定
            @synchronized (array) {
//                NSLog(@"2>%@", [NSThread currentThread]);
                NSLog(@"写入-%zd", i);
                [array addObject:[NSString stringWithFormat:@"%zd-%@", i, randomNumber]];
            }
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", array);
            NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:beginDate];
            NSLog(@"结束：%.3lf", time);
        });
    });
}


//主线程没有卡死，效率最低
//30000次循环 [NSThread currentThread]
//CPU    60%
//Memory 38M
//Time   10.944s
//30000次循环 [NSThread sleepForTimeInterval:0.001]
//CPU    5%
//Memory 38M
//Time   128.353s
- (void)threadTestArray3_async
{
    NSLog(@"开始");
    NSDate *beginDate = [NSDate date];
    NSMutableArray *array = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0 ; i < kLoopCount; i++)
        {
            NSNumber *randomNumber = @(arc4random_uniform(1000));
//            NSLog(@"1>%@", [NSThread currentThread]);
            NSLog(@"获取-%d", i);
            [NSThread sleepForTimeInterval:0.001];
            
//            dispatch_async(dispatch_get_main_queue(), ^{
////                NSLog(@"2>%@", [NSThread currentThread]);
//                NSLog(@"写入-%d", i);
//                [array addObject:[NSString stringWithFormat:@"%zd-%@", i, randomNumber]];
//            });
            
            //几乎等效上面
//            @synchronized (array) {
//                NSLog(@"2>%@", [NSThread currentThread]);
//                NSLog(@"写入-%d", i);
//                [array addObject:[NSString stringWithFormat:@"%zd-%@", i, randomNumber]];
//            }
            
            //一条子线程同步，可以不用加锁
            NSLog(@"写入-%d", i);
            [array addObject:[NSString stringWithFormat:@"%zd-%@", i, randomNumber]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", array);
            NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:beginDate];
            NSLog(@"结束：%.3lf", time);
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
