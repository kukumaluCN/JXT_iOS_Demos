//
//  UIViewController+MyProperty.h
//  CategoryDuplicationProperty
//
//  Created by JXT on 2017/3/3.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MyProperty)

//属性覆盖后，黑屏
//@property (nonatomic, strong) NSNumber * view;

//重名方法
- (UIView *)view;

@property (nonatomic, assign) NSInteger title;

@end
