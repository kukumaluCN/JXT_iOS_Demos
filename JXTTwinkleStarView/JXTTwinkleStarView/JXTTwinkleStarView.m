/***************************************************************
 //工程名称 : JXTTwinkleStarView
 //文件名称 : JXTTwinkleStarView.m
 //创建时间 : 2017/6/13
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/


#import "JXTTwinkleStarView.h"

@implementation JXTTwinkleStarView

#pragma mark - Intial Methods
+ (instancetype)twinkleStarViewWithFrame:(CGRect)frame number:(NSUInteger)number shape:(JXTTwinkleStarViewShape)shape overflowRadius:(CGFloat)overflowRadius
{
    return [[self alloc] initWithFrame:frame number:number shape:shape overflowRadius:overflowRadius];
}

- (instancetype)initWithFrame:(CGRect)frame number:(NSUInteger)number shape:(JXTTwinkleStarViewShape)shape overflowRadius:(CGFloat)overflowRadius
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self createRandomLayerEmitterWithFrame:frame number:number shape:shape overflowRadius:overflowRadius];
    }
    return self;
}

#pragma mark - UI and Layout
- (void)createRandomLayerEmitterWithFrame:(CGRect)frame number:(NSUInteger)number shape:(JXTTwinkleStarViewShape)shape overflowRadius:(CGFloat)overflowRadius
{
    for (int i = 0; i < number; i ++) {
        //layer
        CALayer *fireflyLayer = [CALayer layer];
        fireflyLayer.contents = (__bridge id)[UIImage imageNamed:@"emitter_star"].CGImage;
        
        //shape
        switch (shape) {
            case JXTTwinkleStarViewShapeSquare: {
                fireflyLayer.position = CGPointMake(arc4random_uniform(frame.size.width), arc4random_uniform(frame.size.height));
                break;
            }
            case JXTTwinkleStarViewShapeRound: {
                CGFloat halfWidth = frame.size.width * 0.5;
                CGFloat angleRad = (arc4random_uniform(360))/180.0*M_PI;
                CGFloat radius = arc4random_uniform(halfWidth) + overflowRadius;
                //极坐标变换，且位移
                CGPoint position = CGPointMake(radius * cos(angleRad) + halfWidth, radius * sin(angleRad) + halfWidth);
                fireflyLayer.position = position;
                break;
            }
        }
        
        //bounds/scale
        fireflyLayer.bounds = CGRectMake(0, 0, 19, 19);
        CGFloat scale = 0.5 + arc4random_uniform(149)/150.0;
        fireflyLayer.transform = CATransform3DMakeScale(scale, scale, 0);
        
        //add
        [self.layer addSublayer:fireflyLayer];
        
        //animation
        [self jxt_animateTwinkleWithLayer:fireflyLayer duration:0.8 delay:i * 0.05];
    }
}

#pragma mark - Private Method
//闪烁动效
- (void)jxt_animateTwinkleWithLayer:(CALayer *)layer duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay
{
    CABasicAnimation *twinkleAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    twinkleAnimation.fromValue = @1.0f;
    twinkleAnimation.toValue = @0; //透明度
    twinkleAnimation.autoreverses = YES;
    twinkleAnimation.duration = duration;
    twinkleAnimation.repeatCount = MAXFLOAT;
    twinkleAnimation.beginTime = CACurrentMediaTime() + delay; //延时
    twinkleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    twinkleAnimation.removedOnCompletion = NO; //防止切入后台动画停止
    [layer addAnimation:twinkleAnimation forKey:nil];
}


@end
