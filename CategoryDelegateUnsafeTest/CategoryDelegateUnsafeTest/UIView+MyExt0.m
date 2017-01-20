//
//  UIView+MyExt0.m
//  CategoryDelegateUnsafeTest
//
//  Created by JXT on 2017/1/20.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "UIView+MyExt0.h"

@implementation UIView (MyExt0)

- (void)jxt_addTextField0
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor redColor];
    textField.placeholder = @"TextField-0";
    textField.delegate = self;
    [self addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"UIView+MyExt0");
    return YES;
}

@end
