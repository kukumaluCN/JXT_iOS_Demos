# JXT\_iOS\_Demos
一些iOS相关的测试Demo汇总

## 2017.3.14 ClassPropertyTest
关于xcode8新增的“类属性”的简单应用。  
参考博文：  
1.[iOS 中的类属性](http://blog.csdn.net/u011619283/article/details/53139113)  
2.[Category 的一些事](http://www.jianshu.com/p/17bdfcfd5aa6)

## 2017.3.13 PassthroughView
一种可带自身响应且可事件穿透的视图的实现。类似于UIPopoverController的passthroughViews属性。  
源码附带[WEPopover](https://github.com/werner77/WEPopover)demo作为参考。  
博文参考：  
1.[UIView 中的控件事件穿透 Passthrough 的实现](http://unmi.cc/uiview-event-passthrough/)  
2.[WEPopover](https://github.com/werner77/WEPopover)
 

## 2017.3.9 AddSubviewToLayout
关于`UIView`的`layoutSubviews`方法的触发时机中，除了其他的那些（详见参考博文），这里探讨下关于“addSubview会触发layoutSubviews”这条，当视图存在多个层级时，各个层级在addSubview时触发各自的layoutSubviews方法的时机，是和预想的不太一样的，并不是按照执行addSubview的先后，顺序触发对应的layoutSubviews，而是从展示视图时为时机，再根据层级逐级往下进行的，对于viewController，展示视图的实际就是`[self.view addSubview:v1]`，不添加展示的父视图，其子视图添加显示无意义。  
参考博文：  
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
参考博文：  
[更轻量的 View Controllers](https://objccn.io/issue-1-1/)

## 2017.2.16 ChildViewControllerTest  
关于ChildViewController的简单使用。  
参考博文：  
1.[iOS 5.0 后UIViewController新增：willMoveToParentViewController和didMoveToParentViewController](http://blog.sina.com.cn/s/blog_7b9d64af0101d6p7.html)  
2.[iOS开发 剖析网易新闻标签栏视图切换(addChildViewController属性介绍)](http://blog.csdn.net/hmt20130412/article/details/34523235)

## 2017.2.10 ThreadArrayTest  
关于多线程操作数组的安全性问题，关于多线程的几种使用方式的测试。  
参考博文：  
1.[如何实现一个线程安全的NSMutabeArray，以保证多个线程对数组操作（遍历，插入，删除）的安全？](https://www.zhihu.com/question/35590962)  
2.[iOS 线程安全之@synchronized的用法](http://www.cnblogs.com/jukaiit/p/5570056.html)  
3.[iOS线程安全数组](http://blog.csdn.net/idaretobe/article/details/22191103)  
4.[iOS开发多线程之队列组——下载合并图片](http://blog.csdn.net/sunnyboy9/article/details/44893563)  

## 2017.2.8 Quartz2DDemo
Quartz2D简单入门，一些绘图的基本方法。  
参考博文：  
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
参考博文（作者Lision）：  
[有趣的KVC－几行代码打造一个万能容器对象](http://www.jianshu.com/p/ad2d6681630e)

## 2016.9.25 CAAnimationDelegateTest 
iOS10  CAAnimationDelegate的“适配”  
博文：  
[iOS10 CAAnimationDelegate的简单适配](http://www.jianshu.com/p/e9feb2c0c3f1)  
[iOS10 再谈CAAnimationDelegate相关协议的适配](http://www.jianshu.com/p/38f095b2120d)

## 2016.3.21 JXTAboutNavigationBar
一些关于navigationBar的非常规的但是较为实用的操作，包括利用毛玻璃、动态透明、动态隐藏，以及头视图的动态缩放，并同时涉及了statusBar的动态设置（换色）。  
博文：  
[iOS 关于navigationBar的一些：毛玻璃、透明、动态缩放、动态隐藏](http://www.jianshu.com/p/b2585c37e14b)

## 2016.3.6 JXTAlertView
一种带输入框的自定义alertView的简易封装实现  
博文：  
[iOS 一种带输入框的自定义alertView的简易封装实现](http://www.jianshu.com/p/ef8065282ea4/comments/1652307#comment-1652307)

## 2016.2.23 CountDownButton
一种带倒计时显示的按钮的简易实现逻辑

