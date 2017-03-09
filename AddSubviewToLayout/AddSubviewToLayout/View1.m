//
//  View1.m
//  AddSubviewToLayout
//
//  Created by JXT on 2017/3/9.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "View1.h"

#import "View2.h"

@implementation View1

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        View2 *v = [[View2 alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        v.backgroundColor = [UIColor blackColor];
        v.tag = 201;
        [self addSubview:v];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"view1 - layout");
    NSLog(@"tag:%zd", self.tag);
}

@end
