/***************************************************************
 //工程名称 : JXT_MVC_Demo
 //文件名称 : UIView+JXTDataModelManager.m
 //创建时间 : 2017/3/3
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/

#import "UIView+JXTDataModelManager.h"

#import <objc/runtime.h>

static const void *kJXTDataModelPropertyKey = &kJXTDataModelPropertyKey;

@implementation UIView (JXTDataModelManager)

#pragma mark - DataSource Methods
- (void)setJxt_dataModel:(id)jxt_dataModel
{
    if (jxt_dataModel) {
        objc_setAssociatedObject(self, kJXTDataModelPropertyKey, jxt_dataModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self jxt_reloadData];
    }
    else {
        NSLog(@"jxt_dataModel == nil");
    }
}
- (id)jxt_dataModel
{
    return objc_getAssociatedObject(self, kJXTDataModelPropertyKey);
}

- (void)jxt_reloadData
{
    NSString *msgString = [NSString stringWithFormat:@"%@基类抽象方法执行无效，%@子类必须自己覆盖实现", [UIView class], [self class]];
    NSAssert(NO, msgString);
}


#pragma mark - Layout Methods
- (void)jxt_updateLayoutImmediately
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

@end
