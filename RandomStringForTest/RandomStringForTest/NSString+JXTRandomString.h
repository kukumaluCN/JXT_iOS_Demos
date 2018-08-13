//
//  NSString+JXTRandomString.h
//  RandomStringForTest
//
//  Created by JXT on 2018/8/13.
//  Copyright © 2018年 JXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JXTRandomString)

/**
 字符串随机长度裁剪

 @return 随机长度的子串，index from 0
 */
- (NSString *)jxt_stringWithRandomLength;

/**
 利用CCRandomGenerateBytes生成随机字符串，数字字母组成

 @param length 指定长度
 @return 随机字符串
 */
+ (NSString *)jxt_randomStringWithLength:(size_t)length;

/**
 随机6位数字字符串

 @return 随机6位数
 */
+ (NSString *)jxt_random6Digits;

/**
 随机4位数字字符串

 @return 随机4位数
 */
+ (NSString *)jxt_random4Digits;

/**
 任意长度随机数字字符串

 @param length 指定长度
 @return 随机数字字符串
 */
+ (NSString *)jxt_randomDigitsStringWithLength:(NSUInteger)length;

@end
