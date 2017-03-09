//
//  View3.m
//  AddSubviewToLayout
//
//  Created by JXT on 2017/3/9.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "View3.h"

@implementation View3

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"view3 - layout");
    NSLog(@"tag:%zd", self.tag);
}


@end
