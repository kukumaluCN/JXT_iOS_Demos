//
//  VC2.m
//  ChildViewControllerTest
//
//  Created by JXT on 2017/2/13.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "VC2.h"

@interface VC2 ()

@end

@implementation VC2

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad - %@", self);

    self.view.backgroundColor = [UIColor lightGrayColor];
    self.testButton.tag = 1002;
    [self.view addSubview:self.testButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
