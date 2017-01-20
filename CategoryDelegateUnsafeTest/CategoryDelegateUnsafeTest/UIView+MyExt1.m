//
//  UIView+MyExt1.m
//  CategoryDelegateUnsafeTest
//
//  Created by JXT on 2017/1/20.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "UIView+MyExt1.h"

@implementation UIView (MyExt1)

- (void)jxt_addTextField1
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor redColor];
    textField.placeholder = @"TextField-1";
    textField.delegate = self;
    [self addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"UIView+MyExt1");
    if ([textField isFirstResponder]) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
