//
//  KVCObj.h
//  KVCTest
//
//  Created by JXT on 2017/1/6.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KVCSubObj;

@interface KVCObj : NSObject
{
    NSString *ivar;
    
    @private
    NSString *priIvar1;
}

@property (nonatomic, assign) float floatNumber;

@property (nonatomic, strong) KVCSubObj * subObj;


@property (nonatomic, copy) NSString * string1;
@property (nonatomic, copy) NSString * string2;
@property (nonatomic, copy) NSString * string3;
@property (nonatomic, copy) NSString * string4;
@property (nonatomic, copy) NSString * string5;


@property (nonatomic, strong) NSArray <KVCSubObj *>* subObjs;

@end
