//
//  KVCContainer.m
//  KVCTest
//
//  Created by JXT on 2017/1/13.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "KVCContainer.h"

@interface KVCContainer ()
// 用来放置属性键值对的字典
@property (nonatomic, strong) NSMutableDictionary * mPropertiesDict;
@end

@implementation KVCContainer
// 没有对应key的setter方法且没有找到对应key的属性时调用
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!key || !(key.length > 0)) {
        return ;
    }
    if (!_mPropertiesDict) {
        _mPropertiesDict = [NSMutableDictionary dictionary];
    }
    [_mPropertiesDict setValue:value forKey:key];
}

// 没有对应key的getter方法且没有找到对应key的属性时调用
- (id)valueForUndefinedKey:(NSString *)key
{
    if (!key || !(key.length > 0)) {
        return nil;
    }
    return [_mPropertiesDict valueForKey:key];
}
@end
