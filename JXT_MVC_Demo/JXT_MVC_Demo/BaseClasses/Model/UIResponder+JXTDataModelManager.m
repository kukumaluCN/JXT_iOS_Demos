/***************************************************************
 //工程名称 : JXT_MVC_Demo
 //文件名称 : UIResponder+JXTDataModelManager.m
 //创建时间 : 2017/3/5
 //创建作者 : JXT
 //版权归属 : 霖溦
 //文件描述 :
 ***************************************************************/

#import "UIResponder+JXTDataModelManager.h"

#import <objc/runtime.h>

static const void *kJXTForwardDataModelPropertyKey = &kJXTForwardDataModelPropertyKey;

@implementation UIResponder (JXTDataModelManager)

#pragma mark - jxt_forwardDataModel
- (void)setJxt_forwardDataModel:(id)jxt_forwardDataModel
{
    if (jxt_forwardDataModel) {
        objc_setAssociatedObject(self, kJXTForwardDataModelPropertyKey, jxt_forwardDataModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    else {
        NSLog(@"jxt_forwardDataModel == nil");
    }
}
- (id)jxt_forwardDataModel
{
    return objc_getAssociatedObject(self, kJXTForwardDataModelPropertyKey);
}


#pragma mark - jxt_callbackDataModel
- (void)jxt_setCallbackDataModel:(id)callbackDataModel
{
    if (callbackDataModel) {
        //自动回调
        [self jxt_refreshUIWithCallbackDataModel:callbackDataModel];
    }
    else {
        NSLog(@"callbackDataModel == nil");
    }
}

- (void)jxt_refreshUIWithCallbackDataModel:(id)callbackDataModel
{
    NSString *msgString = [NSString stringWithFormat:@"%@基类抽象方法执行无效，%@子类必须自己覆盖实现", [UIResponder class], [self class]];
    NSAssert(NO, msgString);
}

@end
