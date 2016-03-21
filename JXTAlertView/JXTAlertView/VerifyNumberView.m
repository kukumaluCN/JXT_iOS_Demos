//
//  VerifyNumberView.m
//  JXTAlertView
//
//  Created by JXT on 16/3/6.
//  Copyright © 2016年 JXT. All rights reserved.
//

#import "VerifyNumberView.h"

@implementation VerifyNumberView

#pragma mark - 将view转换为image
+ (UIImage *)convertImageWithView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize boundsSize = view.bounds.size;
    
    //开始绘图
    //第一个参数表示区域大小
    //第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。
    //第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(boundsSize, NO, scale);
    
    //将view上的子view加进来
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //开始生成图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)verifyNumberImage
{
    UILabel * verLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 48)];
    verLabel.text = [self developVerifyString];
    verLabel.font = [UIFont boldSystemFontOfSize:20];
    verLabel.textColor = [UIColor whiteColor];
    verLabel.textAlignment = NSTextAlignmentCenter;
    verLabel.backgroundColor = [UIColor lightGrayColor];
    
    UIImage * image = [self convertImageWithView:verLabel];
    
    return image;
}

+ (NSString *)developVerifyString
{
    NSMutableString * verifyString = [NSMutableString stringWithCapacity:6];
    for(int i = 0; i < 6; i ++) {
        NSInteger temp = arc4random() % 10;
        [verifyString appendFormat:@"%zd", temp];
    }
    return verifyString;
}

+ (UIImage *)iniVerifyNumberImage
{
    UILabel * verLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 48)];
    verLabel.text = @"点击获取验证码";
    verLabel.font = [UIFont boldSystemFontOfSize:16];
    verLabel.textColor = [UIColor orangeColor];
    verLabel.textAlignment = NSTextAlignmentCenter;
    verLabel.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255. blue:237/255. alpha:1];
    
    UIImage * image = [self convertImageWithView:verLabel];
    
    return image;
}

@end
