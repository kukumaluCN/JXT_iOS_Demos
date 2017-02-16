//
//  VC1.m
//  ChildViewControllerTest
//
//  Created by JXT on 2017/2/13.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "VC1.h"

@interface VC1 ()

@end

@implementation VC1

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad - %@", self);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.testButton.tag = 1001;
    [self.view addSubview:self.testButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
