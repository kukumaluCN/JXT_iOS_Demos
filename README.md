# JXT\_iOS\_Demos
一些iOS相关的测试Demo汇总

## 2017.2.8 Quartz2DDemo
Quartz2D简单入门，一些绘图的基本方法。  
博文参考：  
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

