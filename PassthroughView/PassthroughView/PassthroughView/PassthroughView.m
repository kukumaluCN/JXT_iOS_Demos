//
//  PassthroughView.m
//  PassthroughView
//
//  Created by JXT on 2017/3/10.
//  Copyright © 2017年 JXT. All rights reserved.
//

#import "PassthroughView.h"

@implementation PassthroughView
{
    BOOL _testHits;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_testHits)
    {
        return nil;
    }
    
    if (!self.passthroughViews || (self.passthroughViews && self.passthroughViews.count == 0))
    {
        return self;
    }
    else
    {
        UIView *hitView = [super hitTest:point withEvent:event];
        
        if (hitView == self)
        {
            //Test whether any of the passthrough views would handle this touch
            _testHits = YES;
            CGPoint superPoint = [self.superview convertPoint:point fromView:self];
            UIView *superHitView = [self.superview hitTest:superPoint withEvent:event];
            _testHits = NO;
            
            if ([self isPassthroughView:superHitView])
            {
                hitView = superHitView;
            }
        }
        return hitView;
    }
}

- (BOOL)isPassthroughView:(UIView *)view
{
    if (view == nil)
    {
        return NO;
    }
    
    if ([self.passthroughViews containsObject:view])
    {
        return YES;
    }
    
    return [self isPassthroughView:view.superview];
}

- (void)dealloc
{
    self.passthroughViews = nil;
}

@end
