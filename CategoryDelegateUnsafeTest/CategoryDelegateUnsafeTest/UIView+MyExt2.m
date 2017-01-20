//
//  UIView+MyExt2.m
//  CategoryDelegateUnsafeTest
//
//  Created by JXT on 2017/1/20.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "UIView+MyExt2.h"

@implementation UIView (MyExt2)

- (void)jxt_addTextField2
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    textField.borderStyle = UITextBorderStyleBezel;
    textField.backgroundColor = [UIColor greenColor];
    textField.placeholder = @"TextField-2";
    textField.delegate = self;
    [self addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"UIView+MyExt2");
    return YES;
}

@end
