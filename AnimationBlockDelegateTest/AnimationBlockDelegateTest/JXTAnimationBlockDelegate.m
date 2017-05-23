/***************************************************************
 //工程名称 : AnimationBlockDelegateTest
 //文件名称 : JXTAnimationBlockDelegate.m
 //创建时间 : 2017/5/23
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "JXTAnimationBlockDelegate.h"

@interface JXTAnimationBlockDelegate () 
@property (nonatomic, copy) void (^animationDidStart)(void);
@property (nonatomic, copy) void (^animationDidStop)(BOOL finished);
@end

@implementation JXTAnimationBlockDelegate

#pragma mark - Init
+ (instancetype)animationBlockDelegateWithAnimationDidStart:(void(^)(void))animationDidStart animationDidStop:(void(^)(BOOL finished))animationDidStop
{
    JXTAnimationBlockDelegate *animationBlockDelegate = [[JXTAnimationBlockDelegate alloc] init];
    animationBlockDelegate.animationDidStart = animationDidStart;
    animationBlockDelegate.animationDidStop = animationDidStop;
    return animationBlockDelegate;
}


#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.animationDidStart) {
        self.animationDidStart();
    }
    self.animationDidStart = nil;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.animationDidStop) {
        self.animationDidStop(flag);
    }
    self.animationDidStop = nil;
}

@end
