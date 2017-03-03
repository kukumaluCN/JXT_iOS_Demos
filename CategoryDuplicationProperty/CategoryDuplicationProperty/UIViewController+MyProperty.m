//
//  UIViewController+MyProperty.m
//  CategoryDuplicationProperty
//
//  Created by JXT on 2017/3/3.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "UIViewController+MyProperty.h"

#import <objc/runtime.h>

static const void *kMyNumberPropertyKey = &kMyNumberPropertyKey;

@implementation UIViewController (MyProperty)

//- (NSNumber *)view
//{
//    return objc_getAssociatedObject(self, kMyNumberPropertyKey);
//}
//
//- (void)setView:(NSNumber *)view
//{
//    objc_setAssociatedObject(self, kMyNumberPropertyKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (UIView *)view
{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    aView.backgroundColor = [UIColor lightGrayColor];
    return aView;
}

@end
