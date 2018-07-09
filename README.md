# JXT\_iOS\_Demos
一些iOS相关的测试Demo汇总

## 2018.7.9 FindAllEnumOptions 
对于位移运算的枚举定义：  

```objective-c
typedef NS_OPTIONS(NSUInteger, MyOptions) {
    MyOptions_0 = 1 << 0,
    MyOptions_1 = 1 << 1,
    MyOptions_2 = 1 << 2,
    MyOptions_3 = 1 << 3,
    MyOptions_4 = 1 << 4,
    MyOptions_5 = 1 << 5,
    MyOptions_6 = 1 << 6,
    MyOptions_7 = 1 << 7,
    MyOptions_8 = 1 << 8,
};
```

如何遍历取出一个位移类型的枚举值，例如：

```objective-c
MyOptions nowOption = MyOptions_0 | MyOptions_1 | MyOptions_2 | MyOptions_3 | MyOptions_4 | MyOptions_5 | MyOptions_6 | MyOptions_7
```

取出这个值的每一项，提供一种算法：

```objective-c
MyOptions startOption = MyOptions_0; //不变的起点
MyOptions currentOption = MyOptions_0;
MyOptions nowOption = MyOptions_0 | MyOptions_1 | MyOptions_2 | MyOptions_3 | MyOptions_4 | MyOptions_5 | MyOptions_6 | MyOptions_7 | 512;
uint offset = 0;
while (nowOption) {
    //如果存在
    if ((nowOption & currentOption) == currentOption) {
        NSLog(@"- MyOptions_%d = %zd", offset, currentOption);

        //删除当前的
        nowOption ^= currentOption;
    }
    //继续下一个位移
    currentOption = startOption << (++offset);
}
```

这个算法的好处是，设定好起始值，后期维护更新枚举定义，算法基本可以不变。


## 2018.4.8 RemoveSingleElementFromArrayDemo
数组执行元素删除，会删除相同的所有元素值，而不是只删除单个。   
在某些业务场景中，只是想删除单一的一个元素，而不是同值的所有元素，类似的例如数据池的取用。  
本demo采用遍历数组匹配记录index值，并移除特定indexSet集合的方式处理数组，以达到处理效果，实现可能不是很好，但是相对小数据量的处理还是比较简单合适的。

```objective-c
NSArray <NSNumber *>*totalArray = @[@1, @2, @2, @3, @3, @3, @4, @4, @4, @4];
NSArray <NSNumber *>*removeArray = @[@2, @3, @4];

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

NSMutableArray <NSNumber *>*testArray = [NSMutableArray arrayWithArray:totalArray];
[testArray removeObjectsAtIndexes:indexSet];
NSLog(@"removeObjectsAtIndexes - %@", testArray);
```  


## 2018.1.30 WeakStrongDanceDemo
关于

``` objective-c
#define WeakSelf(type) __weak typeof(type)weak##type = type
#define StrongSelf(type) __strong typeof(type)type = weak##type
```

这两个宏在WeakStrongDance中的应用和解释。
`##`在宏里可以连接字符串。这里就是在`block`外把`self`付给`weakself`，然后`block`内把`weakself`还给`self`。`block`外部创建`weakself`，保证了不会有引用计数加一，内部强持有，可以保证在`block`执行前`self`不会被释放。

## 2018.1.26 AboutTimeForiOSDemo
关于`NSDate`、`CFAbsoluteTimeGetCurrent()`、`gettimeofday`、`mach_absolute_time()`、`CACurrentMediaTime()`、`sysctl`相关获取时间函数的简单介绍，详细文章参考博文内容。
> 参考博文：
[iOS关于时间的处理](http://blog.csdn.net/u011619283/article/details/53689076)

## 2017.9.25 IfNilTest
`if (array.count == 0)`这个条件句，包含着两重意思，当`array == nil`时，当`array.count == 0`时，该语句都成立，但是有时也是因为这种双重语义，会导致某些业务场景的bug，这个还是要注意的，`nil == 0`。  
>博文参考：  
1.[Objective-C中nil使用的最佳实践](http://www.cocoachina.com/ios/20141119/10247.html)  
2.[nil/Nil/NULL/NSNull的区别](http://blog.csdn.net/wzzvictory/article/details/18413519)  

## 2017.9.25 DoWhile0MacroTest
在一些宏定义中，经常能看到`do {...} while (0)`这样的语法的应用，它的意义和作用是什么呢？通过研究，发现其能避免一些上下文匹配的错误，防止隐患。具体可以参考下面的文章：  
>参考博文：  
1.[宏定义中的do...while(0)用途](http://www.jianshu.com/p/51ee5d028c76)  
2.[do {...} while (0) 在宏定义中的作用](http://www.cnblogs.com/lanxuezaipiao/p/3535626.html)  
3.[do...while(0)在宏定义中的巧妙用法](http://blog.csdn.net/luoweifu/article/details/38563161)  

## 2017.9.18 ViewBoundsInitErrorTest
一个view初始化时，宽高给负值，那么其bounds会变为(-宽,-高,宽,高)，改变一个view的bounds，其本身不会有影响，但是会影响其子视图的布局，因为子视图相对于其的左边原点改变了，父视图的左上角坐标为负值，那么子视图相对的布局原点一定要偏右下，这样会造成隐式的布局bug，尤其是在view动态初始化时，宽高动态计算，值不确定，这样的bug会很隐蔽，难以定位。

## 2017.9.11 GlobalStaticValueTest
如果在头文件(.h)中定义static修饰的变量，意味着什么呢？全局变量吗？首先编译时不会报错的，但是这并不是一种正确的或者说是恰当的写法，真正的全局变量是用extern来修饰定义的。  
>参考博文：  
[在头文件中使用static定义变量意味着什么](http://www.cnblogs.com/zplutor/archive/2011/08/06/2129401.html)

## 2017.7.31 TableViewCellAnimationTest
一种给TableView的Cell添加动画效果的简单方式，动画效果可自行定义，下面是示例代码，效果见Demo。

``` objective-c
#pragma mark - Cell Animation
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGPoint center = cell.center;
    CGPoint orgCenter = center;
    center.x -= cell.bounds.size.width;
    cell.center = center;
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.center = orgCenter;
    }];
}
```

## 2017.6.14 JXTTwinkleStarView
一种星光闪烁的伪粒子效果的实现，利用CA动画+随机数+延时，可以适用于简单的使用场景。该视图实现提供两种外观形状，可根据不同场景调节使用，方法实现较为简陋，没有特定的封装，可以参考下。
![](/Users/JXT/Desktop/Github_Clone/JXT_iOS_Demos/JXTTwinkleStarView/JXTTwinkleStarView/star.png)

## 2017.5.23 AnimationBlockDelegateTest
利用block将`CAAnimationDelegate`方法进行简易封装，便于使用。    
使用示例：  
``` objective-c
moveAnimation.delegate = [JXTAnimationBlockDelegate animationBlockDelegateWithAnimationDidStart:^{
    NSLog(@"start");
} animationDidStop:^(BOOL finished) {
    NSLog(@"stop - %zd", finished);
}];
```  
>博文参考：  
[View-Layer 协作](https://objccn.io/issue-12-4/)

## 2017.5.18 KVOForInstanceVarTest
KVO监听实例变量的实现  
修改对象属性，会自动触发KVO监听，但是直接修改属性的实例变量，是不会触发KVO的，所以一般都使用set方法来修改属性值（`self.value = newValue`），而不是直接使用实例变量（`_value = newValue`）。  
但是如果类成员对象本身就是实例变量，而不是属性，还需要使用KVO的话，就需要手动实现来使得该实例变量支持KVO。   
>博文参考：   
[手动设定实例变量的KVO实现监听](http://www.cnblogs.com/YouXianMing/p/3902827.html)


## 2017.3.14 ClassPropertyTest
关于xcode8新增的“类属性”的简单应用。  
>参考博文：  
1.[iOS 中的类属性](http://blog.csdn.net/u011619283/article/details/53139113)  
2.[Category 的一些事](http://www.jianshu.com/p/17bdfcfd5aa6)

## 2017.3.13 PassthroughView
一种可带自身响应且可事件穿透的视图的实现。类似于UIPopoverController的passthroughViews属性。  
源码附带[WEPopover](https://github.com/werner77/WEPopover)demo作为参考。  
>博文参考：  
1.[UIView 中的控件事件穿透 Passthrough 的实现](http://unmi.cc/uiview-event-passthrough/)  
2.[WEPopover](https://github.com/werner77/WEPopover)
 

## 2017.3.9 AddSubviewToLayout
关于`UIView`的`layoutSubviews`方法的触发时机中，除了其他的那些（详见参考博文），这里探讨下关于“addSubview会触发layoutSubviews”这条，当视图存在多个层级时，各个层级在addSubview时触发各自的layoutSubviews方法的时机，是和预想的不太一样的，并不是按照执行addSubview的先后，顺序触发对应的layoutSubviews，而是从展示视图时为时机，再根据层级逐级往下进行的，对于viewController，展示视图的实际就是`[self.view addSubview:v1]`，不添加展示的父视图，其子视图添加显示无意义。  
>参考博文：  
1.[layoutSubviews总结](http://blog.csdn.net/bsplover/article/details/7977944)  
2.[iOS开发笔记--什么时候调用layoutSubviews](http://blog.csdn.net/hopedark/article/details/24313445)  

## 2017.3.4 JXT\_MVC\_Demo 
- **JXTDataModelManager**   
使用`UIView`的分类扩展属性`jxt_dataModel`和方法`jxt_reloadData`，令所有`UIView`动态绑定对应的数据模型属性，`UIView`子类重写`jxt_reloadData`方法，在`jxt_dataModel`执行`set`时，会自动回调该方法，从而进行数据UI显示刷新。  
- **BaseTableArrayDataSource**  
将TableView和VC解耦的一次尝试，将DataSource从VC分离，实现单独的代理类，运用OC的多态特性，动态为对应`TableViewCell`类实现数据源协议，并动态绑定数据，刷新数据。

## 2017.3.3 CategoryDuplicationProperty  
使用系统的分类扩展自己的属性和方法时，命名一定要注意规范，一定要添加自己对应的前缀作为“命名空间”标识，即使是不同类的属性也不可和系统属性重名，否则会直接覆盖系统属性或方法，常规的UI层的覆盖可能产生直观的bug易于查找，但是数据层的，就是很难查找的隐患了。

## 2017.3.2 MVCDemo  
运用MVC架构，将TableView和VC解耦的一次尝试，将DataSource从VC分离。将参考文章中的方案做了调整。  
>参考博文：  
[更轻量的 View Controllers](https://objccn.io/issue-1-1/)

## 2017.2.16 ChildViewControllerTest  
关于ChildViewController的简单使用。  
>参考博文：  
1.[iOS 5.0 后UIViewController新增：willMoveToParentViewController和didMoveToParentViewController](http://blog.sina.com.cn/s/blog_7b9d64af0101d6p7.html)  
2.[iOS开发 剖析网易新闻标签栏视图切换(addChildViewController属性介绍)](http://blog.csdn.net/hmt20130412/article/details/34523235)

## 2017.2.10 ThreadArrayTest  
关于多线程操作数组的安全性问题，关于多线程的几种使用方式的测试。  
>参考博文：  
1.[如何实现一个线程安全的NSMutabeArray，以保证多个线程对数组操作（遍历，插入，删除）的安全？](https://www.zhihu.com/question/35590962)  
2.[iOS 线程安全之@synchronized的用法](http://www.cnblogs.com/jukaiit/p/5570056.html)  
3.[iOS线程安全数组](http://blog.csdn.net/idaretobe/article/details/22191103)  
4.[iOS开发多线程之队列组——下载合并图片](http://blog.csdn.net/sunnyboy9/article/details/44893563)  

## 2017.2.8 Quartz2DDemo
Quartz2D简单入门，一些绘图的基本方法。  
>参考博文：  
[iOS Quartz2D详解](http://www.imlifengfeng.com/blog/?p=514#comment-127)

## 2017.1.20 CategoryDelegateUnsafeTest
在分类中添加系统API对应的协议方法是不安全的。  
系统API实现有可能使用这种做法，如果开发者在同样的类的分类中添加了和系统同样的协议方法，就造成了冲突，表现就是，开发者后添加的分类文件中的协议实现会覆盖系统的实现，造成不可预计的bug，例如WKWebView的点击是以tap手势实现，如果开发者在UIView的分类中也实现了tap手势的对应协议方法，就覆盖了系统的实现，造成WKWebView不能正常工作。


## 2017.1.12 DelegateOptimizeTest
利用位段（位域）优化协议方法回调，提升性能。

## 2017.1.9 NSErrorTest
关于NSError的一些简单使用场景，探索error作为输出参数（NSError**）的使用原理。

## 2017.1.6 KVCTest
一些关于KVC的简单实用  
>参考博文（作者Lision）：  
[有趣的KVC－几行代码打造一个万能容器对象](http://www.jianshu.com/p/ad2d6681630e)

## 2016.9.25 CAAnimationDelegateTest 
iOS10  CAAnimationDelegate的“适配”  
>博文：  
[iOS10 CAAnimationDelegate的简单适配](http://www.jianshu.com/p/e9feb2c0c3f1)  
[iOS10 再谈CAAnimationDelegate相关协议的适配](http://www.jianshu.com/p/38f095b2120d)

## 2016.3.21 JXTAboutNavigationBar
一些关于navigationBar的非常规的但是较为实用的操作，包括利用毛玻璃、动态透明、动态隐藏，以及头视图的动态缩放，并同时涉及了statusBar的动态设置（换色）。  
>博文：  
[iOS 关于navigationBar的一些：毛玻璃、透明、动态缩放、动态隐藏](http://www.jianshu.com/p/b2585c37e14b)

## 2016.3.6 JXTAlertView
一种带输入框的自定义alertView的简易封装实现  
>博文：  
[iOS 一种带输入框的自定义alertView的简易封装实现](http://www.jianshu.com/p/ef8065282ea4/comments/1652307#comment-1652307)

## 2016.2.23 CountDownButton
一种带倒计时显示的按钮的简易实现逻辑

