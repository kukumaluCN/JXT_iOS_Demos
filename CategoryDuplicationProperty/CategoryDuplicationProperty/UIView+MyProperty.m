//
//  UIView+MyProperty.m
//  CategoryDuplicationProperty
//
//  Created by JXT on 2017/3/3.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "UIView+MyProperty.h"

#import <objc/runtime.h>

static const void *kMyFramePropertyKey = &kMyFramePropertyKey;

@implementation UIView (MyProperty)

- (NSInteger)frame
{
    NSNumber *num = objc_getAssociatedObject(self, kMyFramePropertyKey);
    return num.integerValue;
}

- (void)setFrame:(NSInteger)frame
{
    objc_setAssociatedObject(self, kMyFramePropertyKey, @(frame), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
