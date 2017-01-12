//
//  ViewController2.h
//  DelegateOptimizeTest
//
//  Created by JXT on 2017/1/12.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController2;
@protocol VC2DataSourceDelegate <NSObject>

@optional
- (void)carryVC2Title:(NSString *)title fetcher:(ViewController2 *)vc2;
- (void)carryVC2Message:(NSString *)message;

@required
- (void)receivedNetWorkDataDict:(NSDictionary *)dict;

@end


@interface ViewController2 : UIViewController

@property (nonatomic, weak) id<VC2DataSourceDelegate> delegate;

@end
