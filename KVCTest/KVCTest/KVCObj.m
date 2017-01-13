//
//  KVCObj.m
//  KVCTest
//
//  Created by JXT on 2017/1/6.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "KVCObj.h"

#import "KVCSubObj.h"

@interface KVCObj ()
@property (nonatomic, copy) NSString * priIvar2;
@end

@implementation KVCObj

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (NSArray<KVCSubObj *> *)subObjs
{
    if (!_subObjs) {
        KVCSubObj *subObj1 = [[KVCSubObj alloc] init];
        KVCSubObj *subObj2 = [[KVCSubObj alloc] init];
        _subObjs = @[subObj1, subObj2];
    }
    return _subObjs;
}

@end
