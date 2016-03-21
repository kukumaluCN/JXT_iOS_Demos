//
//  JXTTransparentBarVC.h
//  ScrollScale
//
//  Created by JXT on 16/3/11.
//  Copyright © 2016年 JXT. All rights reserved.
//
//  ***
//  *   GitHub:https://github.com/kukumaluCN/JXT_iOS_Demos
//  *   博客:http://www.jianshu.com/users/c8f8558a4b1d/latest_articles
//  *   邮箱:1145049339@qq.com
//  ***

#import <UIKit/UIKit.h>

typedef void(^AlphaBlock)(CGFloat alpha);

@interface JXTTransparentBarVC : UIViewController

@property (nonatomic, copy) AlphaBlock alphaBlock;

@end
