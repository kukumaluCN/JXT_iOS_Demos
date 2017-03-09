//
//  View2.m
//  AddSubviewToLayout
//
//  Created by JXT on 2017/3/9.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "View2.h"

@implementation View2

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"view2 - layout");
    NSLog(@"tag:%zd", self.tag);
}

@end
