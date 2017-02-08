//
//  CanvasView.m
//  Quartz2DDemo
//
//  Created by JXT on 2017/2/8.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "CanvasView.h"

@implementation CanvasView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark - DrawRect
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//在drawRect:方法中能取得跟view相关联的图形上下文
//drawRect:方法在什么时候被调用？
    //当view第一次显示到屏幕上时（被加到UIWindow上显示出来）
    //调用view的setNeedsDisplay或者setNeedsDisplayInRect:时

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    switch (self.index) {
        case 0:
            [self drawDemoIndex0WithRect:rect];
            break;
        case 1:
            [self drawDemoIndex1WithRect:rect];
            break;
        case 2:
            [self drawDemoIndex2WithRect:rect];
            break;
        case 3:
            [self drawDemoIndex3WithRect:rect];
            break;
        case 4:
            [self drawDemoIndex4WithRect:rect];
            break;
        case 5:
            [self drawDemoIndex5WithRect:rect];
            break;
        case 6:
            [self drawDemoIndex6WithRect:rect];
            break;
        case 7:
            [self drawDemoIndex7WithRect:rect];
            break;
        case 8:
            [self drawDemoIndex8WithRect:rect];
            break;
        case 9:
            [self drawDemoIndex9WithRect:rect];
            break;
        case 10:
            [self drawDemoIndex10WithRect:rect];
            break;
        default:
            break;
    }
}

//iOS Quartz2D详解:http://www.imlifengfeng.com/blog/?p=514#comment-127


/**
//Quartz2D重要函数
 
 1、常用拼接路径函数
 新建一个起点
 void CGContextMoveToPoint(CGContextRef c, CGFloat x, CGFloat y)
 添加新的线段到某个点
 void CGContextAddLineToPoint(CGContextRef c, CGFloat x, CGFloat y)
 添加一个矩形
 void CGContextAddRect(CGContextRef c, CGRect rect)
 添加一个椭圆
 void CGContextAddEllipseInRect(CGContextRef context, CGRect rect)
 添加一个圆弧
 void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
 
 2、常用绘制路径函数
 一般以CGContextDraw、CGContextStroke、CGContextFill开头的函数，都是用来绘制路径的。
 Mode参数决定绘制的模式
 void CGContextDrawPath(CGContextRef c, CGPathDrawingMode mode)
 绘制空心路径
 void CGContextStrokePath(CGContextRef c)
 绘制实心路径
 void CGContextFillPath(CGContextRef c)
 
 3、矩阵操作函数
 利用矩阵操作，能让绘制到上下文中的所有路径一起发生变化。
 缩放：
 void CGContextScaleCTM(CGContextRef c, CGFloat sx, CGFloat sy)
 旋转：
 void CGContextRotateCTM(CGContextRef c, CGFloat angle)
 平移：
 void CGContextTranslateCTM(CGContextRef c, CGFloat tx, CGFloat ty)
 
 4、其他常用函数
 设置线段宽度
 CGContextSetLineWidth(ctx, 10);
 设置线段头尾部的样式
 CGContextSetLineCap(ctx, kCGLineCapRound);
 设置线段转折点的样式
 CGContextSetLineJoin(ctx, kCGLineJoinRound);
 设置颜色
 CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
 */


/**
 *  Quartz2D的内存管理
 
 关于Quartz2D内存管理，有以下原则：
 （1）使用含有“Create”或“Copy”的函数创建的对象，使用完后必须释放，否则将导致内存泄露。
 （2）使用不含有“Create”或“Copy”的函数获取的对象，则不需要释放
 （3）如果retain了一个对象，不再使用时，需要将其release掉。
 （4）可以使用Quartz 2D的函数来指定retain和release一个对象。例如，如果创建了一个CGColorSpace对象，则使用函数CGColorSpaceRetain和CGColorSpaceRelease来retain和release对象。
 （5）也可以使用Core Foundation的CFRetain和CFRelease。注意不能传递NULL值给这些函数。
 */


#pragma mark - DrawMethods
//画1/4圆（扇形）
- (void)drawDemoIndex0WithRect:(CGRect)rect
{
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 100, 150);
    CGContextAddArc(ctx, 100, 100, 50, -M_PI_2, M_PI, 1);//??????
//    CGContextAddArc(ctx, 100, 100, 50, 0, M_PI_2, 0);

    CGContextClosePath(ctx);
    [[UIColor redColor] set];
    
    CGContextFillPath(ctx);
    
//    CGContextRelease(ctx);
}

//1、画矩形、正方形
- (void)drawDemoIndex1WithRect:(CGRect)rect
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    //3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 路径的颜色
    [[UIColor redColor] set];
    //4.把上下文的内容渲染到View的layer.
//    CGContextStrokePath(ctx); // 描边路径
    CGContextFillPath(ctx);// 填充路径
}

//2、UIBezierPath画扇形
- (void)drawDemoIndex2WithRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    CGFloat startA = 0;
    CGFloat endA = -M_PI_2;
    // 画弧的路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    // 添加一根线到圆心
    [path addLineToPoint:center];
    // 闭合路径
    [path closePath];
    // 路径颜色
    [[UIColor redColor] set];
    // 填充路径
    [path fill];
    // 描边路径
//    [path stroke];
}

//3、画圆形
- (void)drawDemoIndex3WithRect:(CGRect)rect
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    // cornerRadius:圆角半径。矩形的宽高都为200，如果圆角为100，那么两个角之间弧线上任意一点到矩形中心的距离都为100,所以为圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 200, 200) cornerRadius:100];
    //3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    [[UIColor redColor] set];// 路径的颜色
//    [[UIColor redColor] setFill];
//    [[UIColor redColor] setStroke];
    
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    //4.把上下文的内容渲染到View的layer.
//    CGContextStrokePath(ctx);// 描边路径
    CGContextFillPath(ctx);// 填充路径
}

//4、画圆角矩形
- (void)drawDemoIndex4WithRect:(CGRect)rect
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    // cornerRadius:圆角半径。
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 200, 200) cornerRadius:50];
    //3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    [[UIColor redColor] set];// 路径的颜色
    
    //4.把上下文的内容渲染到View的layer.
    CGContextStrokePath(ctx);// 描边路径
    //CGContextFillPath(ctx);// 填充路径
}

//5、画直线
- (void)drawDemoIndex5WithRect:(CGRect)rect
{
    //1.获取跟View相关联的上下文(uigraphics开头)
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.描述路径
    //一条路径可以绘制多条线 路径:path     路径绘制多条线:path使用了两次（2次的起点到终点），都是将线添加到某个点
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(50, 150)];
    //添加一根线Line到某个点
    [path addLineToPoint:CGPointMake(250, 50)];
    
    //画第二根线
    [path moveToPoint:CGPointMake(50, 250)];
    [path addLineToPoint:CGPointMake(250, 100)];
    
    //设置线宽
    CGContextSetLineWidth(ctx, 20);
    //设置线的连接样式
//    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    //设置线的顶角样式
    CGContextSetLineCap(ctx, kCGLineCapRound);// 圆角线条
    //设置线条颜色
    [[UIColor redColor] set];
    
    //3.把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文当中绘制的内容渲染到跟View关联的layer
    CGContextStrokePath(ctx);
}

//6、画曲线
- (void)drawDemoIndex6WithRect:(CGRect)rect
{
    //1.获取跟View相关联的上下文.】
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.描述路径
    UIBezierPath *path = [UIBezierPath  bezierPath];
    //画曲线,设置起点.还有一个控制点(用来控制曲线的方向跟弯曲程度)
    //设置起点
    [path moveToPoint:CGPointMake(10, 150)];
    //添加一要曲线到某个点
    [path addQuadCurveToPoint:CGPointMake(200, 150) controlPoint:CGPointMake(150, 10)];
    //3.把路径添加到上下文当中
    CGContextAddPath(ctx, path.CGPath);
    //4.把上下文的内容渲染View上
    CGContextStrokePath(ctx);
}

//7、画饼图
- (void)drawDemoIndex7WithRect:(CGRect)rect
{
    NSArray *dataArray =  @[@25, @15, @10, @50];
    // 画弧
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    // 半径
    CGFloat radius = rect.size.width * 0.5 - 10;
    
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    
    for (NSNumber *num in dataArray)
    {
        startA = endA;
        // 遍历出第一个对象25,angle =25/100 *2π，即angle = π/2，所以为1/4圆,
        angle = num.intValue / 100.0 * M_PI * 2;
        // 截至角度= 开始的角度+ 遍历出的对象所占整个圆形的角度
        endA = startA + angle;
        // 顺势针画贝塞尔曲线
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        // 设置随机颜色
        [[self randomColor] set];
        // 添加一根线到圆心
        [path addLineToPoint:center];
        // 填充路径
        [path fill];
        // 描边路径
        //      [path stroke];
    }
}
- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:0.6f];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //重绘
    [self setNeedsDisplay];
}

//8、绘制文字
- (void)drawDemoIndex8WithRect:(CGRect)rect
{
    NSString *str = @"drawRect绘制文本，drawRect绘制文本，drawRect绘制文本";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //设置字体
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    //设置颜色
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    //设置描边
    dict[NSStrokeColorAttributeName] = [UIColor blueColor];
    dict[NSStrokeWidthAttributeName] = @3;
    //设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor greenColor];
    shadow.shadowOffset = CGSizeMake(2, 2);
    shadow.shadowBlurRadius = 3;
    dict[NSShadowAttributeName] = shadow;
    
    //设置文字的属性
    //drawAtPoint不会自动换行
    //[str drawAtPoint:CGPointMake(0, 0) withAttributes:dict];
    //drawInRect会自动换行
    [str drawInRect:self.bounds withAttributes:dict];
}

//9、加水印
- (void)drawDemoIndex9WithRect:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor redColor];
    [self addSubview:imageView];
    
    //生成一张图片
    //0.加载图片
    UIImage *oriImage = [UIImage imageNamed:@"test_image.jpg"];
    //1.创建位图上下文(size:开启多大的上下文,就会生成多大的图片)
    UIGraphicsBeginImageContextWithOptions(oriImage.size, NO, [UIScreen mainScreen].scale);
//    UIGraphicsBeginImageContext(oriImage.size); //字符会马像素化模糊
    //2.把图片绘制到上下文当中
    [oriImage drawAtPoint:CGPointZero];
    //3.绘制水印(虽说UILabel可以快速实现这种效果，但是我们也可以绘制出来)
    NSString *str = @"@图片水印";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [str drawAtPoint:CGPointZero withAttributes:dict];
    //4.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭位图上下文
    UIGraphicsEndImageContext();
    
    imageView.image = newImage;
}

//10、屏幕截图
- (void)drawDemoIndex10WithRect:(CGRect)rect
{
    [self drawDemoIndex9WithRect:rect];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //生成图片
        //1.开启一个位图上下文
//        UIGraphicsBeginImageContext(self.bounds.size);
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
        //2.把View的内容绘制到上下文当中
        CGContextRef ctx =  UIGraphicsGetCurrentContext();
        //UIView内容想要绘制到上下文当中, 必须使用渲染的方式
        [self.layer renderInContext:ctx];
        //3.从上下文当中生成一张图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        //4.关闭上下文
        UIGraphicsEndImageContext();
        //把图片转成二进制流
        //NSData *data = UIImageJPEGRepresentation(newImage, 1);
        NSData *data = UIImagePNGRepresentation(newImage);
        
        //写入下载文件夹
        NSString *path = @"/Users/JXT/Downloads/screenshot.png";//[NSString stringWithFormat:@"%@/screenshot.png", NSHomeDirectory()];
        [data writeToFile:path atomically:YES];
        NSLog(@"%@", path);
    });
}

@end
