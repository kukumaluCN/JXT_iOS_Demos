/***************************************************************
 //工程名称 : AnimationBlockDelegateTest
 //文件名称 : JXTAnimationBlockDelegate.h
 //创建时间 : 2017/5/23
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import <QuartzCore/QuartzCore.h>

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface JXTAnimationBlockDelegate : NSObject <CAAnimationDelegate>
#else
@interface JXTAnimationBlockDelegate : NSObject
#endif

/**
 CAAnimationDelegate代理对象初始化

 @param animationDidStart 动画开始执行block回调
 @param animationDidStop 动画结束执行block回调
 @return 代理对象实例
 */
+ (instancetype)animationBlockDelegateWithAnimationDidStart:(void(^)(void))animationDidStart
                                           animationDidStop:(void(^)(BOOL finished))animationDidStop;

@end
