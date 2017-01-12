//
//  ViewController.m
//  AnimationTest
//
//  Created by JXT on 2016/9/25.
//  Copyright © 2016年 JXT. All rights reserved.
//

#import "ViewController.h"

static NSString *const kAnimationKey = @"scaleAnimation";

//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface ViewController () <CAAnimationDelegate>
#else
@interface ViewController ()
#endif

@property (nonatomic, strong) UIView * testView;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //view
    self.testView = ({
        UIView *testView = [[UIView alloc] initWithFrame:CGRectZero];
        testView.backgroundColor = [UIColor redColor];
        [self.view addSubview:testView];
        testView;
    });
    
    //animation
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = @(0.5);
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation * bounceAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    bounceAnimation.toValue = @(150);
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.5;
    animationGroup.repeatCount = 5;
    animationGroup.autoreverses = YES; //自动回复，往复运动
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = NO; //协议方法保持对象
    animationGroup.animations = @[scaleAnimation, bounceAnimation];
    [self.testView.layer addAnimation:animationGroup forKey:kAnimationKey];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.testView.frame = CGRectMake((self.view.bounds.size.width-200)*0.5, (self.view.bounds.size.height-200)*0.5, 200, 200);
}

#pragma mark - Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[self.testView.layer animationForKey:kAnimationKey]]) {
        NSLog(@"动画结束");
    }
}

@end
