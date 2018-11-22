//
//  NSString+JXTAdd.m
//  JXTKit
//
//  Created by JXT on 2018/11/22.
//  Copyright © 2018 JXT. All rights reserved.
//

#import "NSString+JXTAdd.h"

@implementation NSString (JXTAdd)

- (void)jxt_enumerateRangeOfString:(NSString *)searchString usingBlock:(void (^)(NSRange searchStringRange, NSUInteger idx, BOOL *stop))block
{
    if ([self isKindOfClass:[NSString class]] && self.length &&
        [searchString isKindOfClass:[NSString class]] && searchString.length) {
        NSArray <NSString *>*separatedArray = [self componentsSeparatedByString:searchString];
        if (separatedArray.count < 2) {
            return ;
        }
        NSUInteger count = separatedArray.count - 1; //少遍历一次，因为拆分之后，最后一部分是没用的
        NSUInteger length = searchString.length;
        __block NSUInteger location = 0;
        [separatedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull componentString, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == count) {
                *stop = YES;
            }
            else {
                location += componentString.length; //跳过待筛选串前面的串长度
                if (block) {
                    block(NSMakeRange(location, length), idx, stop);
                }
                location += length; //跳过待筛选串的长度
            }
        }];
    }
}


//获取一个子串在所在字符串中所有的range数组
- (NSArray <NSValue *>*)jxt_rangeValuesOfString:(NSString *)searchString
{
    if ([self isKindOfClass:[NSString class]] && self.length &&
        [searchString isKindOfClass:[NSString class]] && searchString.length) {
        NSArray <NSString *>*separatedArray = [self componentsSeparatedByString:searchString];
        if (separatedArray.count < 2) {
            return nil;
        }
        NSMutableArray <NSValue *>*rangeValueArray = [NSMutableArray array];
        NSUInteger count = separatedArray.count - 1; //少遍历一次，因为拆分之后，最后一部分是没用的
        NSUInteger length = searchString.length;
        __block NSUInteger location = 0;
        [separatedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull componentString, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == count) {
                *stop = YES;
            }
            else {
                location += componentString.length; //跳过待筛选串前面的串长度
                [rangeValueArray addObject:[NSValue valueWithRange:NSMakeRange(location, length)]];
                location += length; //跳过待筛选串的长度
            }
        }];
        return [NSArray arrayWithArray:rangeValueArray];
    }
    return nil;
}


- (void)jxt_enumerateStringBySentencesUsingBlock:(void (^)(NSString * substring, NSRange substringRange, BOOL *stop))block
{
    if (![self isKindOfClass:[NSString class]] || !self.length) {
        return ;
    }
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationBySentences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (block) {
            block(substring, substringRange, stop);
        }
    }];
}

@end
