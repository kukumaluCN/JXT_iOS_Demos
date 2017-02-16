//
//  VC3.m
//  ChildViewControllerTest
//
//  Created by JXT on 2017/2/13.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "VC3.h"

@interface VC3 ()

@end

@implementation VC3

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad - %@", self);

    self.view.backgroundColor = [UIColor grayColor];
    self.testButton.tag = 1003;
    [self.view addSubview:self.testButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
