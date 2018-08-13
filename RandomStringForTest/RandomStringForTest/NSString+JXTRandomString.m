//
//  NSString+JXTRandomString.m
//  RandomStringForTest
//
//  Created by JXT on 2018/8/13.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import "NSString+JXTRandomString.h"

//这是导入了所有加密库的头文件
#import <CommonCrypto/CommonCrypto.h>
//如果只是使用random函数，那么只要做如下导入即可
#import <CommonCrypto/CommonRandom.h>

@implementation NSString (JXTRandomString)

- (NSString *)jxt_stringWithRandomLength
{
    return [self substringToIndex:arc4random_uniform((uint32_t)(self.length))];
}

//利用CCRandomGenerateBytes实现随机字符串的生成
+ (NSString *)jxt_randomStringWithLength:(size_t)length
{
    if (length < 1) {
        return nil;
    }
    
    length = length*0.5;
    unsigned char digest[length];
    CCRNGStatus status = CCRandomGenerateBytes(digest, length);
    if (status == kCCSuccess) {
        return [self private_jxt_stringFrom:digest length:length];
    }
    return nil;
}

//将bytes转为字符串
+ (NSString *)private_jxt_stringFrom:(unsigned char *)digest length:(size_t)length
{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [string appendFormat:@"%02x",digest[i]];
    }
    return string;
}


+ (NSString *)jxt_random6Digits
{
    //iOS获取六位随机数(可以自动补位比如"0")
    //0～4294967295
//    NSUInteger tmpLength = length;
//    if (tmpLength > 9) {
//        tmpLength = 9;
//    }
//    NSInteger places = pow(10, tmpLength);
//    uint32_t a = arc4random() % places;
    
    return [NSString stringWithFormat:@"%06d", arc4random() % 1000000];
}

+ (NSString *)jxt_random4Digits
{
    return [NSString stringWithFormat:@"%04d", arc4random() % 10000];
}

+ (NSString *)jxt_randomDigitsStringWithLength:(NSUInteger)length
{
    NSString *randomDigits = @"";
    for (int i = 0; i < length; i ++) {
        randomDigits = [randomDigits stringByAppendingFormat:@"%d", (arc4random() % 10)];
    }
    return randomDigits;
}

@end
