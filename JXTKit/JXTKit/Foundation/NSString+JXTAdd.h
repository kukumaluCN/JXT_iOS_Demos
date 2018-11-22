//
//  NSString+JXTAdd.h
//  JXTKit
//
//  Created by JXT on 2018/11/22.
//  Copyright © 2018 JXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JXTAdd)

/**
 遍历字符串中所有的重复子串
 
 @param searchString 子串，如果子串不属于被筛选串、length==0，直接return
 @param block 遍历执行，可以获得每一个子串的range和序号
 */
- (void)jxt_enumerateRangeOfString:(NSString *)searchString usingBlock:(void (^)(NSRange searchStringRange, NSUInteger idx, BOOL *stop))block;


/**
 获取字符串中所有子串的rangeValue数组

 @param searchString 子串，如果子串不属于被筛选串，返回nil，length==0，返回为nil
 @return NSRange->NSValue数组
 */
- (NSArray <NSValue *>*)jxt_rangeValuesOfString:(NSString *)searchString;


/**
 将字符串按句子拆分为子串，具体规则见`NSStringEnumerationBySentences`

 @param block 执行block
 */
- (void)jxt_enumerateStringBySentencesUsingBlock:(void (^)(NSString * substring, NSRange substringRange, BOOL *stop))block;

@end
