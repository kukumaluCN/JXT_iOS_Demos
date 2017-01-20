//
//  UIView+Add1.m
//  CategoryDelegateUnsafeTest
//
//  Created by JXT on 2017/1/20.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "UIView+Add1.h"

@implementation UIView (Add1)

- (void)jxt_addTextFielAdd1
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 200, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor redColor];
    textField.placeholder = @"TextField-Add1";
    textField.delegate = self;
    [self addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"UIView+Add1");
    return YES;
}

@end
